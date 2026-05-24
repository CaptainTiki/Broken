# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Broken** is a precision 2.5D melee platformer with Metroidvania-style upgrades, built in **Godot 4.6** (Forward Plus / DirectX 12 on Windows). The visual style is a layered low-poly diorama. The project follows a documented milestone plan — current state: **M0 complete, M1 (Forest Art/Gameplay Slice) in progress**.

Full design documentation lives in `docs/`:
- `docs/platformer_gdd.md` — game design document (pillars, combat, progression, milestones)
- `docs/architecture_guide.md` — coding rules (strong typing, scale, node-first design)
- `docs/art_style_guide.md` — art direction, layered diorama rules, biome palette specs
- `docs/milestones/` — per-milestone deliverables and status

## Engine & Tools

- **Engine:** Godot 4.6 (run via `godot` on PATH, or open `project.godot` in the editor)
- **Physics:** Jolt Physics 3D (configured in `project.godot`)
- **No build step.** Run the project from the Godot editor or via `godot --path . res://system/main.tscn`.
- **No test suite or linter** exists yet — validate mechanics by running the gym level or forest test scene.

## Architecture

### Scene Entry Point

`system/main.tscn` is the main scene. It owns:
- `LevelContainer` — dynamically loaded levels swap in here
- `Player` (CharacterBody3D) — `system/player_controller.gd`
- `GameCamera` (Camera3D) — `system/game_camera.gd`
- `DebugHud` (CanvasLayer) — `system/debug_hud.gd`

Levels follow the template in `world/levels/level.tscn`:
```
Level (Node3D)
├── PlayerSpawn (Marker3D)
├── Geometry (Node3D)
├── Gameplay (Node3D)   ← terrain, enemies, collectibles
└── Environment (Node3D) ← background layers
```

### Key Scripts

| Script | Purpose |
|---|---|
| `system/main.gd` | Level load/unload, dev mode toggle, respawn (hold Q 0.5s) |
| `system/player_controller.gd` | CharacterBody3D movement — walk, jump (coyote/buffer), dash |
| `system/game_camera.gd` | Orthographic follow cam (game) + free-pan (dev mode) |
| `system/debug_hud.gd` | Runtime overlay showing velocity, timers, cam state |

### Player Controller Tuning

All physics parameters are exported — adjust in the Godot Inspector without editing code:
- `max_move_speed: 7.0`, `jump_velocity: 11.2`
- `fall_gravity: 42.0`, `jump_gravity: 28.0`
- Coyote time: `0.1s`, jump buffer: `0.12s`
- Dash: `18.75 u/s`, duration `0.16s`, cooldown `0.28s`

### Camera Modes

Toggle with **C**. Orthographic (20-unit size, follows player) vs Perspective (22 FOV, free-pan in dev mode). Dev mode (**F10**) frees the camera from player control.

### World Scale

**1 Godot unit = 1 meter.** Player capsule: 0.35 radius, 1.8m tall. Terrain pieces use Z-depth of 1.6 units for consistent camera composition.

### Modular Asset Kits

- `world/terrain/forest/forest_terrain_kit.tscn` — collision + mesh platform pieces (1m/2m/4m platforms, ramps, cliffs, ledge caps, floating platforms)
- `world/environment/forest/forest_dressing_kit.tscn` — scatter props (grass clumps, bushes, rocks, trees, roots, vines, mushrooms, flowers, background trees)
- `art/materials/forest/` — shared `StandardMaterial3D` resources referenced by the kits

Levels are assembled by instancing these kits, not duplicating geometry.

### 6-Layer Depth Composition (Art Style)

Every scene uses six depth layers along the Z-axis:
1. Foreground frame (grass, branches)
2. Gameplay lane (terrain, player at Z=0)
3. Near midground (bushes, short rocks)
4. Large midground silhouettes (big trunks)
5. Far background (pale distant trees)
6. Sky / backdrop (gradient)

## Coding Conventions

From `docs/architecture_guide.md`:
- **Strong type hints everywhere** — never use `:=` type inference
- **Node-first design** — short, focused scripts; prefer composition over inheritance
- **Human-readable naming** throughout (no abbreviations)
- Do not specify GUIDs in scene files — let Godot assign them
- 1 unit = 1 meter; never deviate from the established scale baseline

## Input Map

| Action | Key |
|---|---|
| Move | A / D / W / S |
| Jump | Space |
| Dash | Shift |
| Respawn | Q (hold 0.5s) |
| Dev mode toggle | F10 |
| Camera mode toggle | C |

## Current Milestone (M1 — Forest Gameplay Slice)

Active files under development:
- `art/materials/forest/forest_background.tres` (modified)
- `system/main.tscn` (modified)
- `world/levels/forest_style_test.tscn` (modified)

The gym level (`world/levels/gym.tscn`) is the stable M0 reference — use it to validate movement mechanics without art noise.
