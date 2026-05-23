# Quick GDD — Precision Melee Metroidvania Platformer

## 1. High Concept

A precision 2.5D platformer with melee-focused combat, expressive movement, Metroidvania-style upgrades, and a high-narrative world delivered through exploration, environmental storytelling, and character encounters.

The game supports two satisfying play styles:

- **Collection Playthrough:** explore deeply, find upgrades, secrets, lore, optional rooms, hidden collectibles, and completion rewards.
- **Speedrun Playthrough:** move fast, skip optional content, route efficiently, use an on-screen timer, and master movement/combat execution.

The core fantasy is simple:

> Master movement, master melee combat, unlock new abilities, and cut a path through a mysterious layered world.

---

## 2. Genre and Format

### Genre
Precision platformer / combat platformer / Metroidvania-lite

### Camera and Presentation
- 2.5D side-scrolling gameplay.
- Orthographic camera.
- Low-poly layered diorama art style.
- Modular levels with rich environmental dressing.

### Session Feel
- Moment-to-moment play should feel fast, responsive, and skill-based.
- Levels should reward both careful exploration and aggressive speed.
- Combat should interrupt platforming as little as possible; the best combat should feel like part of movement.

---

## 3. Design Pillars

## Pillar 1 — Precision Movement
Movement must feel clean, responsive, and fair.

Core expectations:
- Tight jump control.
- Coyote time.
- Jump buffering.
- Variable jump height.
- Fast recovery from mistakes.
- Clear collision rules.
- Player deaths should feel earned, not cheap.

## Pillar 2 — Melee Combat With Momentum
Combat should be mostly close-range and movement-driven.

Core expectations:
- Primary melee weapon.
- Directional attacks.
- Air attacks.
- Dash/evade integration.
- Enemy tells and readable hitboxes.
- Skillful positioning matters more than stat grinding.

## Pillar 3 — Metroidvania Upgrades
Progression unlocks new movement and combat options that also open new routes.

Core expectations:
- Movement upgrades unlock traversal gates.
- Combat upgrades create new tactical options.
- Optional upgrades reward exploration.
- Backtracking should reveal new paths, shortcuts, and secrets.

## Pillar 4 — Two Playthrough Styles
The game should be enjoyable for both completionists and speedrunners.

Core expectations:
- Collectibles and secrets for explorers.
- On-screen timer for speedrunners.
- Route-friendly level design.
- Optional content should be valuable but skippable.
- Bosses/challenges should reward mastery.

## Pillar 5 — High Narrative, Written Later
The game should reserve space for a strong story, but early development should not block on final writing.

Core expectations:
- World has mystery and emotional stakes.
- Narrative delivery through rooms, NPCs, objects, and environmental context.
- Story can be layered in after core mechanics and world structure are proven.

---

## 4. Target Experience

The player should feel:

- Fast when they understand a route.
- Clever when they find a secret.
- Powerful when melee combat clicks.
- Curious when they see unreachable areas.
- Motivated to replay for better times or higher completion.

The game should create the classic loop:

> See obstacle → learn movement → overcome challenge → gain upgrade → unlock new route → discover deeper mystery.

---

## 5. Core Gameplay Loop

1. Enter a level/region.
2. Platform through hazards and terrain challenges.
3. Fight enemies using melee combat and movement.
4. Discover collectibles, lore, shortcuts, or upgrade gates.
5. Unlock new ability or key progression item.
6. Revisit earlier areas with new options.
7. Push deeper into the world.
8. Finish with either high completion or a faster route.

---

## 6. Player Controller

### Required Baseline
The player controller is the foundation of the entire game.

Required movement features:
- Walk/run.
- Jump.
- Variable jump height.
- Coyote time.
- Jump buffer.
- Air control.
- Ground acceleration/deceleration.
- Fall speed cap.
- Slope/platform handling.
- Clean collision response.

### Possible Movement Upgrades
Potential progression abilities:

- Dash.
- Air dash.
- Double jump.
- Wall slide.
- Wall jump.
- Ledge grab.
- Ground pound.
- Grapple/swing.
- Charged leap.
- Attack-cancel movement.
- Downward slash bounce.

### Movement Philosophy
Movement should be easy to understand, hard to master.

Basic traversal should be comfortable. Optional routes, speed paths, and advanced collectibles can demand higher execution.

---

## 7. Combat Design

### Combat Focus
Combat is melee-first. Ranged attacks, if present, should be limited, earned, costly, or utility-focused.

### Core Combat Actions
Required:
- Basic melee attack.
- Air melee attack.
- Directional attack support.
- Enemy knockback or hit reaction.
- Player damage reaction.
- Enemy telegraphs.
- Clean hitboxes/hurtboxes.

Possible:
- Charged attack.
- Parry.
- Dodge/dash cancel.
- Downward bounce attack.
- Heavy weapon variant.
- Fast weapon variant.
- Combo chain.
- Special attack meter.

### Weapon Direction
Melee weapons should change feel, not just numbers.

Possible weapon types:

- **Sword:** balanced reach, speed, and damage.
- **Dagger/Claws:** fast attacks, low reach, movement-friendly.
- **Hammer/Axe:** slow, high damage, armor-breaking.
- **Spear:** longer reach, precise thrusts.
- **Whip/Chain:** flexible range, traversal/combat crossover.

### Combat Philosophy
Combat should not become a separate mini-game that stops the platforming. The best fights should use terrain, movement, spacing, and timing.

---

## 8. Enemy Design

### Enemy Roles
Early enemy set should include:

- **Patroller:** basic walking enemy.
- **Jumper:** pressures vertical movement.
- **Shielded Enemy:** requires positioning or specific attack angle.
- **Flying Enemy:** tests air control and attack timing.
- **Charger:** teaches dodge/jump timing.
- **Turret/Spitter:** creates movement pressure.

### Enemy Rules
- Every enemy needs a clear silhouette.
- Every attack needs a readable tell.
- Enemy colors should contrast with local biome colors.
- Enemies should support platforming challenges, not just block hallways.

---

## 9. Progression and Upgrades

### Upgrade Categories

#### Movement Upgrades
Open new traversal routes and speedrun shortcuts.

Examples:
- Double jump.
- Dash.
- Wall jump.
- Grapple.
- Ground pound.

#### Combat Upgrades
Change fighting options and enemy interactions.

Examples:
- Heavy strike.
- Parry.
- Air slash.
- Downward bounce attack.
- Charged weapon attack.

#### Utility Upgrades
Support exploration and collection.

Examples:
- Map reveal.
- Secret detection.
- Hazard resistance.
- Unlock specific doors or mechanisms.

#### Optional Upgrades
Reward explorers without being mandatory for speedrunners.

Examples:
- Health fragments.
- Weapon enhancements.
- Movement efficiency upgrades.
- Lore collections.
- Cosmetic unlocks.

### Upgrade Gate Philosophy
Every major upgrade should do at least two jobs:

1. Make the player feel stronger or more expressive.
2. Open new routes or shortcuts.

---

## 10. Exploration and Collection

### Collectible Types
Potential collectible categories:

- Currency shards.
- Lore fragments.
- Hidden relics.
- Health upgrades.
- Weapon upgrade materials.
- Map fragments.
- Challenge tokens.
- Cosmetic unlocks.

### Completion Tracking
The game should support collection-focused players with:

- Region completion percentage.
- Total collectible count.
- Optional secret rooms.
- Post-game cleanup support.
- Final completion summary.

### Collection Philosophy
Collectibles should reward curiosity and skill, not random wall-hugging misery.

Secrets should feel clever, not cruel.

---

## 11. Speedrun Support

### Required Speedrun Features
- On-screen timer.
- Timer visibility toggle.
- Pause behavior defined clearly.
- End-of-run summary.
- Completion percentage shown separately from time.

### Possible Speedrun Modes

#### Any% Mode
Finish the game as fast as possible with minimal required progression.

#### 100% Mode
Finish with all required collectibles/upgrades.

#### No Major Glitches Mode
Default intended route category.

#### Chapter/Region Time Trials
Optional later feature for practicing individual areas.

### Speedrun Design Rules
- Cutscenes/dialogue should be skippable after first viewing.
- Timer behavior should be consistent.
- Major progression routes should be readable and learnable.
- Advanced movement tricks are welcome if they are skill-based and stable.
- Optional collectibles should not be required for normal completion.

---

## 12. Narrative Direction

### Narrative Priority
High narrative is intended, but final writing comes later.

Early development should reserve structure for:

- Character motivation.
- World mystery.
- Environmental storytelling.
- NPC encounters.
- Region-specific lore.
- Upgrade justification.
- Ending variations or completion-based ending details.

### Delivery Methods
Potential narrative delivery:

- Environmental details.
- Short NPC conversations.
- Lore relics.
- Memory fragments.
- Region intro/outro moments.
- Boss encounters.
- Visual storytelling through ruins, biomes, and changes in the world.

### Narrative Rule
Narrative should enhance exploration, not stop the game every five steps.

The player should be able to move fast when replaying.

---

## 13. World Structure

### Overall Structure
A connected world made of multiple biomes/regions, each with its own traversal identity, enemy set, visual palette, and upgrade gates.

Possible regions:

1. Forest.
2. Mountainside.
3. Cave.
4. Desert.
5. Swamp.
6. Evil Castle.

### Region Design Goals
Each region should include:

- Main route.
- Optional exploration branches.
- Upgrade gate.
- Shortcut back to earlier area.
- Unique enemy type.
- One region-specific mechanic or hazard.
- Collectible set.
- Narrative/lore hook.

---

## 14. Level Design Rules

### Room Design
Rooms should usually have a clear purpose:

- Movement challenge.
- Combat challenge.
- Mixed challenge.
- Secret/collectible room.
- Narrative room.
- Rest/checkpoint room.
- Upgrade tutorial room.
- Shortcut connector.

### Precision Platformer Rules
- Hazards must be readable.
- Checkpoints must respect difficulty spikes.
- Failure should reset quickly.
- Controls must be consistent.
- Hard challenges should be optional more often than mandatory.

### Metroidvania Rules
- Show locked routes before the player can access them.
- Make upgrades memorable.
- Create satisfying return paths.
- Avoid backtracking with no new gameplay.

---

## 15. Art Direction Summary

The game uses a layered low-poly diorama style.

Visual goals:
- Strong silhouettes.
- Modular terrain.
- Organic scatter props.
- Controlled biome palettes.
- Foreground/midground/background depth.
- Readable player and enemies.

The art should look atmospheric and handcrafted while remaining achievable for a solo developer.

---

## 16. Audio Direction Placeholder

Audio is not yet defined, but the game should eventually support:

- Responsive movement sounds.
- Satisfying melee impact sounds.
- Biome-specific ambience.
- Subtle collectible audio cues.
- Boss/combat music layers.
- Speedrun-friendly music that does not become exhausting.

---

## 17. UI Direction

### Core UI
Required:
- Health display.
- Current collectible/currency display.
- Optional on-screen timer.
- Region completion summary.
- Pause menu.
- Settings menu.

### Speedrun UI
Required:
- On-screen timer toggle.
- Current run time.
- Final run time.
- Completion percentage.

Possible later:
- Split timer support.
- Best time display.
- Region timer.
- Death count.

### Collection UI
Required eventually:
- Map screen.
- Region completion percent.
- Found/total collectibles.
- Upgrade inventory.

---

## 18. Save and Checkpoint Direction

### Save System Goals
- Support normal exploration sessions.
- Support speedrun attempts.
- Allow completion cleanup.

### Checkpoints
- Frequent enough for precision platforming.
- Placed before major challenges.
- Fast respawn.
- Clear visual language.

### Speedrun Saves
To be defined later.

Possible options:
- Timer continues through death.
- Timer pauses only in menus if allowed by selected mode.
- Separate speedrun profile/mode.

---

## 19. Milestone Plan

## M0 — Player Controller Test Harness
Build reusable movement, camera, collision, and test-level foundation.

Deliverables:
- Player controller.
- Orthographic camera.
- Graybox movement test level.
- Debug overlay.
- Jump/movement tuning values.

## M1 — Forest Art/Gameplay Slice
Build a short playable forest slice using the M0 controller.

Deliverables:
- Modular forest terrain.
- Layered forest background.
- One enemy.
- One collectible.
- Basic melee attack placeholder.
- Screenshot-worthy scene.

## M2 — Combat and Damage Slice
Prove melee combat against multiple enemy types.

Deliverables:
- Player attack system.
- Enemy health/damage.
- Player damage/death/respawn.
- Combat room test.
- Basic weapon feel pass.

## M3 — First Upgrade Loop
Add the first Metroidvania-style upgrade and route gate.

Deliverables:
- One movement upgrade.
- One locked route.
- One shortcut opened by upgrade.
- Upgrade tutorial room.

## M4 — Collection and Timer Support
Add collection tracking and speedrun timer basics.

Deliverables:
- Collectible system.
- Region completion tracking.
- On-screen timer.
- End-of-run summary placeholder.

## M5 — Vertical Slice
Combine movement, combat, upgrade progression, collection, timer, and narrative placeholder in one representative region.

---

## 20. Initial Scope Boundaries

### In Scope Early
- Player controller.
- Camera.
- Modular terrain.
- Forest visual slice.
- Basic melee.
- Basic enemy.
- Basic collectible.
- On-screen timer foundation.
- First movement upgrade.

### Out of Scope Early
- Full story writing.
- Full world map.
- Multiple weapons.
- Multiple biomes fully built.
- Bosses.
- Full save system.
- Polished UI.
- Advanced speedrun categories.
- Final music/audio.

---

## 21. Current Development Focus

The immediate next goal is **M0: Player Controller Test Harness**.

The project should not judge the final art style or build full levels until the player controller and camera are comfortable enough to test those spaces fairly.

After M0, the project moves to **M1: Forest Art/Gameplay Slice**, where the chosen layered low-poly style is proven in a short playable scene.

