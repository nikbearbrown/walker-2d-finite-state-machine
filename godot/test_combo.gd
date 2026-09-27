extends SceneTree
var failures := 0
var checks := 0
func _initialize():
	call_deferred("run")
func check(ok: bool, label: String):
	checks += 1
	if not ok: failures += 1
	print("PASS " if ok else "FAIL ", label)
func tap():
	var event := InputEventKey.new()
	event.keycode = KEY_F
	event.pressed = true
	Input.parse_input_event(event)
	await process_frame
	event = InputEventKey.new()
	event.keycode = KEY_F
	Input.parse_input_event(event)
func run():
	root.size = Vector2i(1280,720)
	var demo: Node = load("res://Demo.tscn").instantiate()
	root.add_child(demo)
	await create_timer(0.1).timeout
	var f: Node = demo.get_node("Player/StateMachine")
	var sword: Node = demo.get_node("Player/BodyPivot/WeaponPivot/Offset/Sword")
	await tap()
	await create_timer(0.14).timeout
	check(sword.combo_count == 1, "first attack")
	check(sword.attack_input_state == sword.AttackInputStates.LISTENING, "animation opens buffer")
	await tap()
	await create_timer(0.03).timeout
	check(sword.attack_input_state == sword.AttackInputStates.REGISTERED, "second F buffered")
	await create_timer(0.15).timeout
	check(sword.combo_count == 2, "second swing starts")
	await create_timer(0.06).timeout
	await tap()
	await create_timer(0.22).timeout
	check(sword.combo_count == 3, "third swing starts")
	check(sword.attack_current.get("damage") == 3, "third swing damage metadata")
	check(sword.get_node("AnimationPlayer").current_animation == "attack_medium", "third swing medium animation")
	await tap()
	await create_timer(0.6).timeout
	check(sword.combo_count == 0 and not sword.visible, "combo finishes despite fourth F")
	check(f.current_state.name == "Idle" and f.states_stack.size() == 1, "one push/pop for full combo")
	await tap()
	await create_timer(0.04).timeout
	check(sword.combo_count == 1, "subsequent combo restarts at one")
	await create_timer(0.6).timeout
	check(f.current_state.name == "Idle", "subsequent single attack ends")
	demo.queue_free()
	await process_frame
	print("RESULT ",checks," checks; ",failures," failures")
	quit(1 if failures else 0)
