# Evidence and friction — 2026-09-27 09:36 UTC

## 10:36 UTC continuation

- Read all three debug scenes fully; complete scene-file source read now done.
  Input harness expanded to verify actual label text during Idle, Jump/Idle stack
  and landing pop. `input-debug-20260927.log`: 18/18 pass, exit 0 clean. Original
  14-check log preserved. With separate combo run, 29 assertions now pass.
- Font binary inspected locally with fc-scan/strings and hashed. It identifies
  Source Code Pro Bold 2.030 and SIL OFL1.1. See FONT-PROVENANCE.md; full separate
  license packaging still pending. No font replacement or source edit performed.
- No visible windows, fake gameplay, capture or film render started. Existing
  capture constraint remains the external blocker. Films/human review remain
  pending; next feasible queue item may proceed without retiring this entry.

## 10:06 UTC continuation

- Read full Demo, Player, Bullet and Sword scenes, including sword animation
  method tracks. No production gameplay changes made.
- Added test_combo.gd: actual-scene F-key events, real-time animation progression,
  no direct attack calls/state mutation. `combo-20260927.log` exits 0 clean with
  11/11 assertions: buffer opens, second press registers, second/third swings,
  third damage metadata/medium animation, fourth press bounded, one stack pop,
  and next single attack starts/finishes. This plus prior 14 checks is state
  evidence only. Damage metadata does not establish actual hit/damage behavior.
- Main scene has no enemy/Health target or environment collider. Collision and
  damage testing would require an explicitly labeled fixture, not a claim of
  existing gameplay. Die is present as a node but not mapped in player states;
  do not claim a tested death/revival loop.
- Debug scene audit and embedded font-license review still pending. No matching
  root COPYRIGHT glob was found; no license conclusion inferred from absence.
- No renderer/worker active; known factory/capture blockers unchanged. Both
  films remain pending. Continue this item's audit next.

- Read source README, project settings and all original GDScript files. Inspected
  scene node/connection inventory; full scene/animation resources not yet audited.
  No source AGENTS.md found. Copied into a new sibling directory, preserving UIDs
  and original assets; retained upstream MIT license. Source git status clean.
- `import-20260927.log`: editor import exit 0, no script errors.
- `runtime-20260927.log`: ordinary headless startup, quit-after 120, exit 0 clean.
- `input-20260927.log`: 14/14 actual-scene input/state checks pass, exit 0 clean.
  Harness uses normal keyboard input paths, no forced state changes, direct
  callbacks or repositioning. Root viewport explicitly 1280x720.
- Single attack only: combo buffering/third attack and physical collisions are
  not established. BodyPivot height and sword.visible assertions are state
  measurements, not claims that rendered frames were inspected.
- Asset listing attempted nonexistent `assets/`; no files changed by that probe.
  SourceCodePro-Bold font was imported; its specific license/provenance audit
  remains required before film completion. All copied source files preserved.
- Existing user-closed capture window constraint still blocks film capture.
  Both films and human review remain pending, with no false approval. Continue
  audit/tests for this item next; do not mark review-ready based on these checks.
