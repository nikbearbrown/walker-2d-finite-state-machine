# Walker — Hierarchical Finite State Machine

This is a local Walker adaptation of Godot's `2d/finite_state_machine` demo. A
top-down character on an empty floor shows the State programming pattern:
hierarchical states and a pushdown automaton, where Jump, Stagger and Attack
stack on top of Idle or Move and pop back off. It sits in Walker as a teaching
demo of that pattern. It is a tech demo, not a game: there are no enemies and
no goal. The damage, health and death code in the source cannot be triggered in
this scene. Headless tests (18 + 11 checks) verify the movement, jump, stagger,
attack combo, bullet and debug-stack behaviour. Visual review, font-license
packaging and both films are still pending.

## How to run

Open `godot/project.godot` in Godot 4.7 and run the main scene (`Demo.tscn`).

Controls (also shown on screen):

- Move: WASD or the arrow keys.
- Shoot: R.
- Attack: F (press again during a swing to combo).
- Stagger (simulate damage): X.
- Jump: Space.
- Sprint: Shift.

Headless test: `Godot --headless --path godot --script res://test_input.gd`.

## Design

- [GDD.md](GDD.md): the recovered game design document (identical copy of
  `design/GDD.md`).
- [design/DECK.html](design/DECK.html): slide deck for review.
- [design/IMPLEMENTATION-MAP.md](design/IMPLEMENTATION-MAP.md): feature → scene/script paths.
- [design/decisions.md](design/decisions.md): open questions.

The GDD is a **recovered, unapproved description** of what the code does,
produced by Walker's `/gdd reverse` pass in silent mode. No design gate has been
signed.

## Source & license

An independent local adaptation of the Godot demo `2d/finite_state_machine` at
`a3b5c113112f77291d5f3d1360f33a882fdc52f7`, by the Godot Engine contributors.
The upstream MIT license is retained in LICENSE.md, and the original README,
assets and UIDs are retained. The only production change is the application
title. The source checkout has no edits.

The embedded font's provenance (Source Code Pro Bold, SIL Open Font License 1.1
per the font binary) is recorded in FONT-PROVENANCE.md. Separate font-license
packaging remains pending.

## Status

Godot 4.7.2 headless import and bounded startup pass. `godot/test_input.gd`
instantiates the actual Demo.tscn and sends keyboard events via
Input.parse_input_event. 14 assertions pass for idle/move, walking/running, jump
push/pop and body height, stagger, attack/sword visibility, and bullet spawn.
This is headless state evidence, not gameplay footage or a human playtest.

An additional `test_combo.gd` passes 11 keyboard-driven combo/stack assertions
(see combo-20260927.log). No physical target damage or rendered frames have been
verified. The expanded input/debug-label run passes 18 assertions
(input-debug-20260927.log), and all scene files have now been read.

Font-license packaging, collision/damage, visual review and both native-4K Liam
films remain pending. No recording window was opened, because the known capture
constraint remains unresolved. See FRICTIONAL.md for the evidence trail.

Repository: https://github.com/nikbearbrown/walker-2d-finite-state-machine
