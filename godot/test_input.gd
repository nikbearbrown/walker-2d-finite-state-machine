extends SceneTree

var failures := 0
var checks := 0
func _initialize():
	call_deferred("run")
func check(ok: bool, label: String):
	checks += 1
	if not ok: failures += 1
	print("PASS " if ok else "FAIL ", label)
func key(code: int, down: bool, physical := false):
	var e := InputEventKey.new()
	if physical: e.physical_keycode = code
	else: e.keycode = code
	e.pressed = down
	Input.parse_input_event(e)
func run():
	root.size = Vector2i(1280,720)
	var demo: Node = load("res://Demo.tscn").instantiate()
	root.add_child(demo)
	await create_timer(0.1).timeout
	var p: Node = demo.get_node("Player")
	var f: Node = p.get_node("StateMachine")
	check(f.current_state.name == "Idle", "initial Idle")
	var stack_label: Node = demo.get_node("Control/StatesStackDiplayer/VBoxContainer/HBoxContainer/States")
	check(stack_label.text == "Idle\n", "debug stack initially Idle")
	var start: Vector2 = p.position
	key(KEY_D,true,true)
	await create_timer(0.15).timeout
	check(f.current_state.name == "Move" and p.position.x > start.x + 20, "D moves right in Move")
	check(f.current_state.speed == 450, "walk speed")
	key(KEY_SHIFT,true)
	await create_timer(0.05).timeout
	check(f.current_state.speed == 700, "Shift run speed")
	key(KEY_SHIFT,false)
	key(KEY_D,false,true)
	await create_timer(0.05).timeout
	check(f.current_state.name == "Idle", "release restores Idle")
	key(KEY_SPACE,true)
	await create_timer(0.1).timeout
	key(KEY_SPACE,false)
	check(f.current_state.name == "Jump" and f.states_stack.size() == 2, "Space pushes Jump")
	check(p.get_node("BodyPivot").position.y < -10, "jump raises body pivot")
	check(stack_label.text == "Jump\nIdle\n", "debug stack shows Jump over Idle")
	check(p.get_node("StateNameDisplayer").text == "Jump", "state label follows transition")
	await create_timer(0.8).timeout
	check(f.current_state.name == "Idle" and f.states_stack.size() == 1, "landing pops Idle")
	check(stack_label.text == "Idle\n", "debug stack follows landing pop")
	key(KEY_X,true)
	await create_timer(0.05).timeout
	key(KEY_X,false)
	check(f.current_state.name == "Stagger", "X enters Stagger")
	await create_timer(1.5).timeout
	check(f.current_state.name == "Idle", "stagger animation restores Idle")
	key(KEY_F,true)
	await create_timer(0.05).timeout
	key(KEY_F,false)
	check(f.current_state.name == "Attack", "F enters Attack")
	check(p.get_node("BodyPivot/WeaponPivot/Offset/Sword").visible, "sword enabled during attack")
	await create_timer(1.5).timeout
	check(f.current_state.name == "Idle" and f.states_stack.size() == 1, "attack completes and pops Idle")
	var spawner: Node = p.get_node("BodyPivot/BulletSpawn")
	key(KEY_R,true)
	await process_frame
	key(KEY_R,false)
	check(spawner.get_child_count() > 1, "R spawns bullet")
	demo.queue_free()
	await process_frame
	print("RESULT ",checks," checks; ",failures," failures")
	quit(1 if failures else 0)
