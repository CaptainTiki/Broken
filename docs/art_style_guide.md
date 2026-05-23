# Art Style Guide — Layered Low-Poly Diorama Platformer

## 1. Style Identity

### Working Style Name
**Layered Low-Poly Diorama**

### Core Visual Promise
This project should look like a handmade outdoor diorama viewed through a side-scrolling camera: chunky low-poly shapes, strong silhouettes, layered depth, atmospheric color separation, and readable characters moving through dense but controlled environments.

The style is not realistic. It is not neon-first. It is not painterly-high-detail. It should feel handcrafted, readable, moody, and modular.

### Design Pillars

#### 1. Readable Gameplay First
The player, enemies, hazards, pickups, and interactables must always be easier to read than decorative foliage, rocks, trees, or background silhouettes.

#### 2. Simple Geometry, Rich Composition
Individual assets should be simple. Scenes should feel rich because of layering, repetition, scale contrast, and smart placement.

#### 3. Depth Through Layers
Every finished environment should use multiple depth layers:

- Foreground framing layer
- Gameplay lane
- Near midground props
- Large midground silhouettes
- Far background silhouettes
- Sky or distant backdrop

#### 4. Limited Palette Per Biome
Each biome needs a controlled palette. Avoid every asset having its own color idea. Strong palette discipline makes simple assets look intentional.

#### 5. Modular Terrain, Organic Dressing
The underlying terrain can be grid-pieceable and modular. The final visible scene should hide that modularity with grass, rocks, roots, shrubs, debris, vines, bones, crystals, rubble, or other scatter props.

#### 6. Detail From Repetition
Small repeating details provide texture:

- Leaf speckles
- Grass cards
- Pebbles
- Mushrooms
- Vines
- Small flowers
- Cracks
- Roots
- Dust puffs
- Broken stones

The scene should feel detailed without individual objects becoming complex.

---

## 2. Global Camera and Presentation Rules

### Camera
- Use a side-view or 2.5D orthographic camera.
- Keep the gameplay plane clean and readable.
- Background layers should sit behind the player with obvious depth separation.
- Foreground framing can overlap the camera edges but should rarely cover the player.

### Camera Angle
The reference images suggest a slightly elevated side-view, not pure flat 2D. The player appears in a 3D world, but the composition behaves like a 2D platformer.

Recommended camera behavior:

- Orthographic projection.
- Camera looks mostly sideways into the scene.
- Slight downward angle is acceptable.
- Avoid extreme perspective distortion.

### Scale
- Use `1 Godot unit = 1 meter` as the shared world scale.
- The baseline player height is approximately `1.8` units.
- Player is the scale anchor.
- Grass can reach knee to waist height but should not hide the character silhouette.
- Trees can be enormous and stylized.
- Background objects can be oversized to create fairy-tale depth.

### Lighting
Use lighting as mood support, not as the primary style.

Recommended baseline:

- Soft directional light.
- Ambient fill.
- Fog/depth tint for background layers.
- Low contrast on far background.
- Higher contrast only around the gameplay lane.

Avoid:

- Excessive bloom.
- Heavy neon glow as the main visual identity.
- Realistic physically accurate lighting that fights the stylized shapes.
- Too many colored lights competing in one scene.

---

## 3. Geometry and Asset Rules

### Modeling Style
Assets should use low-poly, flat-shaded or lightly smoothed geometry.

Recommended traits:

- Chunky forms.
- Broad planes.
- Visible faceting is acceptable.
- Simplified silhouettes.
- Few material slots per asset.
- Low-frequency detail rather than tiny sculpted noise.

### Asset Complexity Rule
An ordinary environmental asset should be producible in roughly **30–60 minutes** once the style is established.

Hero assets can take longer, but most of the world should come from fast, reusable pieces.

### Texture Rule
Prefer material colors, gradients, vertex color, or simple hand-painted accents over complex texture maps.

Texture-like detail should often come from:

- Geometry repetition.
- Small mesh clusters.
- Dithered/speckled leaf dots.
- Simple color patches.
- Decal-like markings.

### Silhouette Rule
An object should still be recognizable when viewed as a dark shape.

Good silhouettes:

- Tall jagged tree trunks.
- Round bush blobs.
- Angular rocks.
- Sloping cliff chunks.
- Hanging vines.
- Castle spikes.
- Crystal clusters.

Weak silhouettes:

- Generic smooth blobs without features.
- Thin noisy shapes everywhere.
- Too many similarly sized vertical lines.
- Props whose outline disappears against similar backgrounds.

---

## 4. Character, Enemy, and Interactable Readability

### Player Readability
The player should be visible at all times in normal gameplay.

Rules:

- Do not place same-value foliage directly behind the player lane for long stretches.
- Add subtle contrast through costume color, rim light, or a contact shadow.
- Avoid foreground grass crossing the player’s face/body during normal movement.
- Keep the player animation silhouette clear.

### Enemy Readability
Enemies should be simpler and more contrasty than background props.

Rules:

- Enemies should have a clear primary shape.
- Use stronger saturation or value contrast than scenery.
- Give enemies simple idle motion so they do not read as decoration.
- Avoid enemy colors that match the local grass/rock too closely.

### Interactables and Pickups
Interactables may use small glow accents, but glow should be restrained.

Acceptable uses:

- Crystals.
- Magic doors.
- Checkpoints.
- Collectibles.
- Enemy eyes.
- Cave fungi.
- Castle cursed runes.

Glow is seasoning. Do not pour the whole bottle in the soup.

---

## 5. Layering System

### Standard Environment Stack
Every biome should be built from the same basic stack.

#### Layer A — Foreground Frame
Closest-to-camera elements used for depth and framing.

Examples:

- Large grass blades.
- Branches.
- Rocks.
- Flowers.
- Mushrooms.
- Ruined stone.
- Cave crystals.

Rules:

- Can be darker and more saturated.
- Should not frequently cover the player.
- Best used at screen edges or bottom edge.

#### Layer B — Gameplay Lane
The actual navigable platform/terrain area.

Examples:

- Ground chunks.
- Platforms.
- Slopes.
- Bridges.
- Ledges.
- Hazards.
- Enemies.
- Pickups.

Rules:

- Highest gameplay clarity.
- Strong collision consistency.
- Terrain silhouettes should support player movement readability.

#### Layer C — Near Midground
Decor immediately behind the gameplay lane.

Examples:

- Bushes.
- Tree bases.
- Rocks.
- Roots.
- Short ruins.
- Cacti.
- Bones.

Rules:

- Adds richness.
- Must not compete with player/enemies.
- Slightly darker or lower contrast than gameplay objects.

#### Layer D — Large Midground Silhouettes
Big shapes that define the biome.

Examples:

- Huge tree trunks.
- Mountain cliffs.
- Dunes.
- Cave columns.
- Swamp trees.
- Castle walls.

Rules:

- Use strong silhouettes.
- Lower detail than near midground.
- Usually darker or desaturated.

#### Layer E — Far Background
Atmospheric distant shapes.

Examples:

- Pale forest trunks.
- Mountain ranges.
- Distant dunes.
- Cave openings.
- Swamp fog silhouettes.
- Castle towers.

Rules:

- Low contrast.
- Desaturated.
- Often blue/gray/purple tinted.
- Should imply distance, not detail.

#### Layer F — Sky / Void / Backdrop
The broad color field behind everything.

Examples:

- Night sky.
- Cloudy mountain sky.
- Heat-haze desert sky.
- Cave darkness.
- Swamp fog.
- Blood moon castle sky.

Rules:

- Simple gradient preferred.
- Avoid loud high-frequency detail.
- Supports mood and palette.

---

## 6. Modular Terrain System

### Terrain Kit Philosophy
Terrain should be grid-pieceable and fast to assemble, then visually disguised with dressing props.

The player should feel like they are exploring organic spaces, but the developer should be building with reusable chunks.

### Core Terrain Pieces
Every biome should have versions of:

- Flat 1x1 block.
- Flat 2x1 block.
- Flat 4x1 block.
- Left slope.
- Right slope.
- Tall wall/cliff face.
- Ledge cap.
- Platform underside.
- Corner/end cap.
- Floating platform.
- Small bridge or connector.

### Seam Hiding Props
Every biome needs seam-breaker props.

Examples:

- Forest: grass clumps, roots, mushrooms.
- Mountain: snow chunks, pebbles, scrub grass.
- Desert: sand piles, cracked stones, bones.
- Cave: stalagmites, crystals, rubble.
- Swamp: reeds, mud mounds, roots.
- Evil castle: rubble, chains, banners, broken stone.

### Terrain Collision Rule
Visual meshes can be irregular, but collision should remain simple and predictable.

Use clean collision shapes even when the visible mesh is jagged or organic.

---

# Biome Guides

---

## 7. Forest Biome

### Mood
Ancient, dense, quiet, slightly magical, layered, cool-toned. The forest should feel deep and mysterious without becoming horror.

### Visual Keywords
- Deep woods.
- Tall trunks.
- Hanging vines.
- Dense grass.
- Round bushes.
- Speckled leaf clusters.
- Pale blue-gray distance.
- Small mushrooms and flowers.
- Hidden crystals or faint magic accents.

### Palette Direction

#### Foreground / Gameplay
- Deep green.
- Dark moss green.
- Muted emerald.
- Brown-gray trunks.
- Occasional pale flowers or mushrooms.

#### Midground
- Dark blue-green.
- Desaturated bark gray.
- Cool shadow green.

#### Background
- Blue-gray trunks.
- Pale misty blue.
- Low-saturation distant greens.

### Shape Language
- Vertical tree trunks dominate the background.
- Bushes are rounded clusters.
- Grass is long triangular blade clusters.
- Rocks are chunky and angular.
- Vines are thin vertical lines used sparingly.

### Terrain Style
Forest terrain should feel like soft earth and moss-covered platforms.

Terrain pieces:

- Mossy ground slab.
- Root-covered ledge.
- Dirt cliff face.
- Grass-topped platform.
- Hollow log bridge.
- Sloped root ramp.

### Scatter Props
Required forest prop kit:

- Grass clump small.
- Grass clump medium.
- Tall grass silhouette.
- Round bush small.
- Round bush large.
- Mushroom cluster.
- Flower cluster.
- Rock cluster.
- Root clump.
- Hanging vine strip.
- Thin background sapling.
- Large trunk slab.

### Background Composition
Forest backgrounds should use repeating vertical trunks at multiple depths.

Layer suggestions:

- Far pale trunks.
- Mid blue-gray trunks.
- Large dark foreground trunks.
- Hanging vine strips from top silhouettes.
- Round bush silhouettes behind grass.

### Readability Risks
- Player lost in grass.
- Enemies blending into green foliage.
- Too many vertical trunks creating visual noise.
- Foreground grass hiding combat.

### Rules
- Keep the player lane slightly cleaner than the surrounding foliage.
- Use darker/less saturated grass behind the player.
- Put bright enemies on darker ground or give them a unique hue.
- Use grass clumps in clusters, not an even carpet everywhere.

---

## 8. Mountainside Biome

### Mood
Open, crisp, windy, exposed, grand. This should be a contrast to the dense forest: more sky, more distance, sharper silhouettes.

### Visual Keywords
- Snow-capped peaks.
- Rocky ledges.
- Thin air.
- Clouds below or behind.
- Wind-bent grass.
- Scrub bushes.
- Pine silhouettes.
- Stone platforms.
- High-altitude ruins.

### Palette Direction

#### Foreground / Gameplay
- Slate gray rock.
- Cool brown stone.
- Desaturated green scrub.
- Snow white/blue highlights.

#### Midground
- Blue-gray cliffs.
- Muted pine green.
- Shadowed rock faces.

#### Background
- Pale blue mountains.
- White snow caps.
- Soft sky blue.
- Cloud whites with blue shadow.

### Shape Language
- Sharp triangular peaks.
- Angular rock slabs.
- Stepped cliffs.
- Wind-swept grass strips.
- Sparse vertical pine silhouettes.

### Terrain Style
Mountainside terrain should be harder and more angular than forest terrain.

Terrain pieces:

- Flat rock ledge.
- Snow-capped ledge.
- Cracked cliff wall.
- Diagonal slope rock.
- Floating stone platform.
- Broken bridge plank.
- Narrow cliff shelf.

### Scatter Props
Required mountainside prop kit:

- Small rock pile.
- Angular boulder.
- Snow patch.
- Wind grass clump.
- Scrub bush.
- Tiny pine.
- Dead branch.
- Cloud/fog plane.
- Icicle cluster.
- Broken stone marker.

### Background Composition
Mountainside should lean heavily on far-background silhouettes.

Layer suggestions:

- Far mountain range with snow caps.
- Mid mountain ridge.
- Pale clouds between ridges.
- Near dark cliff forms.
- Sparse pine silhouettes.

### Readability Risks
- White/snow areas overpowering the player.
- Gray rocks becoming visually monotonous.
- Platforms blending into background cliffs.

### Rules
- Gameplay platforms should have darker underside or clear top-edge highlight.
- Far mountains should be much lower contrast than playable rocks.
- Use snow as an accent/cap, not a full white-out unless the player has strong contrast.
- Add wind movement to grass/clouds for atmosphere.

---

## 9. Desert Biome

### Mood
Hot, open, hostile, sun-bleached, ancient. Desert should feel sparse compared to forest, but not empty.

### Visual Keywords
- Sand dunes.
- Dry cliffs.
- Bleached bones.
- Cacti or alien succulents.
- Ruined stone.
- Heat haze.
- Scattered shrubs.
- Cracked ground.
- Sunlit silhouettes.

### Palette Direction

#### Foreground / Gameplay
- Warm sand.
- Ochre.
- Burnt orange.
- Dusty brown.
- Pale dry grass.

#### Midground
- Muted terracotta.
- Shadow brown.
- Dusty olive for sparse plants.

#### Background
- Pale yellow sky.
- Faded orange dunes.
- Blue-purple distant mountains.
- Washed-out horizon.

### Shape Language
- Smooth dunes.
- Angular cracked stones.
- Tall cactus silhouettes.
- Curved dry branches.
- Rib/bone arcs.
- Ruined geometric blocks.

### Terrain Style
Desert terrain should mix sandy tops with cracked stone supports.

Terrain pieces:

- Sand-topped platform.
- Cracked stone slab.
- Dune slope.
- Dry cliff face.
- Ruined sandstone block.
- Half-buried platform.
- Sandfall edge.

### Scatter Props
Required desert prop kit:

- Small cactus.
- Tall cactus.
- Dry grass tuft.
- Bone pile.
- Skull or rib arc.
- Cracked stone.
- Sand mound.
- Broken ruin block.
- Pottery shard.
- Heat shimmer plane, optional.

### Background Composition
Desert backgrounds should breathe. Use fewer objects but larger shapes.

Layer suggestions:

- Far dunes with soft curves.
- Distant mesas or mountains.
- Ruin silhouettes.
- Large sun or bright sky gradient.
- Occasional drifting dust planes.

### Readability Risks
- Too much beige flattening the scene.
- Player blending into warm ground.
- Empty-looking levels due to sparse dressing.

### Rules
- Use strong shadows under platforms to separate gameplay terrain.
- Add small clusters of props rather than evenly spaced decoration.
- Use background gradients and dune layers to avoid flat emptiness.
- Keep interactables cooler or brighter than the sand palette.

---

## 10. Cave Biome

### Mood
Dark, enclosed, damp or crystalline, mysterious. Caves should feel narrower and more dangerous than outdoor spaces.

### Visual Keywords
- Stalagmites.
- Stalactites.
- Rock columns.
- Crystal clusters.
- Underground pools.
- Faint fungus glow.
- Rubble.
- Deep shadow.
- Layered rock silhouettes.

### Palette Direction

#### Foreground / Gameplay
- Dark blue-gray rock.
- Charcoal.
- Cool purple shadow.
- Muted moss or fungus green.
- Crystal accent colors.

#### Midground
- Deeper blue-gray.
- Dark violet.
- Desaturated teal.

#### Background
- Near-black blue.
- Soft cave fog.
- Dim silhouettes.

### Shape Language
- Jagged vertical spikes.
- Chunky rock columns.
- Low angular ceilings.
- Crystal triangles.
- Rounded fungus caps.
- Broken stone chunks.

### Terrain Style
Cave terrain should have strong silhouettes on both floors and ceilings.

Terrain pieces:

- Rock floor slab.
- Jagged ceiling piece.
- Cave wall backdrop.
- Crystal platform.
- Broken stone bridge.
- Sloped rock ramp.
- Underground pool edge.

### Scatter Props
Required cave prop kit:

- Stalagmite small.
- Stalagmite large.
- Stalactite strip.
- Crystal cluster small.
- Crystal cluster large.
- Fungus cap.
- Pebble/rubble pile.
- Cave root.
- Drip marker/wet spot.
- Pool edge rocks.

### Background Composition
Cave backgrounds should use darkness and silhouettes rather than visible sky.

Layer suggestions:

- Near-black void/gradient.
- Mid cave wall silhouettes.
- Large rock columns.
- Occasional distant opening or glow source.
- Foreground stalactite frame at top.

### Readability Risks
- Scene too dark to read.
- Glow props pulling too much attention.
- Player silhouette lost against dark rocks.

### Rules
- Player needs a stronger rim/contact shadow strategy in caves.
- Use glow sparingly as navigation accents.
- Keep hazards brighter or more animated than background spikes.
- Avoid making every crystal glow; reserve glow for important clusters.

---

## 11. Swamp Biome

### Mood
Wet, murky, overgrown, uneasy, humid. Swamp should feel denser and more twisted than forest, but less vertical and majestic.

### Visual Keywords
- Murky water.
- Cypress-like trees.
- Hanging moss.
- Mud banks.
- Reeds.
- Mushrooms.
- Fireflies.
- Twisted roots.
- Rotting logs.
- Fog close to the ground.

### Palette Direction

#### Foreground / Gameplay
- Dark olive green.
- Mud brown.
- Wet black-green.
- Moss yellow-green.
- Desaturated reed tan.

#### Midground
- Murky green-gray.
- Deep brown trunks.
- Blue-green fog.

#### Background
- Pale sickly green mist.
- Blue-gray tree silhouettes.
- Low-contrast water reflections.

### Shape Language
- Twisted tree roots.
- Drooping moss strands.
- Horizontal logs.
- Reed clusters.
- Round mushroom shapes.
- Uneven mud platforms.

### Terrain Style
Swamp terrain should feel soft, wet, and unstable while preserving clear collision.

Terrain pieces:

- Mud platform.
- Root bridge.
- Rotting log platform.
- Water-edge bank.
- Moss-covered slope.
- Sunken stone block.
- Bog island chunk.

### Scatter Props
Required swamp prop kit:

- Reed cluster.
- Hanging moss strip.
- Twisted root.
- Mud mound.
- Small mushroom.
- Large mushroom.
- Rotting stump.
- Water plant.
- Firefly particle cluster.
- Broken log.

### Background Composition
Swamp should use low fog and tangled silhouettes.

Layer suggestions:

- Ground fog plane.
- Distant tree silhouettes.
- Midground root tangles.
- Hanging moss from upper frame.
- Reflective/dark water strips.

### Readability Risks
- Everything becoming green-brown mush.
- Water edges unclear.
- Foreground reeds hiding enemies.
- Fireflies/glow accents distracting from pickups.

### Rules
- Keep water/hazard surfaces clearly separated by color/value.
- Use hanging moss mostly above player height.
- Use brighter enemy/pickup colors than the swamp palette.
- Reserve firefly glow as ambient detail, not gameplay language.

---

## 12. Evil Castle Biome

### Mood
Gothic, hostile, sharp, ancient, cursed. This biome should feel constructed rather than natural, with hard silhouettes and oppressive verticality.

### Visual Keywords
- Broken stone walls.
- Tall towers.
- Arches.
- Spikes.
- Chains.
- Tattered banners.
- Gargoyle silhouettes.
- Red/purple sky.
- Cursed windows.
- Black iron.

### Palette Direction

#### Foreground / Gameplay
- Dark stone gray.
- Blue-black shadows.
- Desaturated purple.
- Iron black.
- Red accent.

#### Midground
- Cold gray walls.
- Deep navy shadows.
- Purple fog.

#### Background
- Dark violet sky.
- Blood moon red or pale moon blue.
- Distant castle silhouettes.
- Storm clouds.

### Shape Language
- Tall vertical walls.
- Pointed rooftops.
- Triangular spikes.
- Arched windows.
- Broken battlements.
- Hanging chains.
- Hard rectangular blocks.

### Terrain Style
Castle terrain should be modular, blocky, and architectural.

Terrain pieces:

- Stone floor block.
- Brick wall face.
- Battlement top.
- Broken stair slope.
- Arch platform.
- Iron bridge.
- Spike-lined ledge.
- Cracked pillar.

### Scatter Props
Required castle prop kit:

- Broken stone chunk.
- Chain segment.
- Tattered banner.
- Iron spike.
- Candle cluster.
- Gargoyle statue.
- Cracked pillar.
- Skull pile.
- Cursed rune decal.
- Broken window silhouette.

### Background Composition
Castle backgrounds should use tall silhouettes and negative space.

Layer suggestions:

- Far castle towers.
- Moon/sky gradient.
- Mid wall silhouettes.
- Large arches behind gameplay lane.
- Foreground chains or broken pillars.

### Readability Risks
- Too many dark objects flattening together.
- Spikes and decoration confused with actual hazards.
- Red accents overused, making important objects unclear.

### Rules
- Real hazards must have a distinct material/readability treatment.
- Decorative spikes should be darker/desaturated and kept away from gameplay paths.
- Use red/purple glow sparingly for interactables, bosses, cursed doors, or danger cues.
- Keep platform top edges clearly visible.

---

# 13. Cross-Biome Asset Checklist

Every biome should eventually have:

## Terrain
- Flat block.
- Long platform.
- Slope left.
- Slope right.
- Cliff/wall face.
- Platform underside.
- End cap.
- Floating platform.

## Background
- Far silhouette set.
- Mid silhouette set.
- Large near silhouette set.
- Sky/backdrop gradient.

## Scatter
- Small ground scatter.
- Medium ground scatter.
- Tall vertical scatter.
- Edge/seam hider.
- Rare accent prop.

## Gameplay Clarity
- Hazard visual language.
- Pickup visual language.
- Interactable visual language.
- Enemy contrast test.
- Player contrast test.

---

# 14. Palette Discipline Rules

### Biome Palette Structure
Each biome should define:

- 3–5 primary environment colors.
- 2–3 background colors.
- 1–2 accent colors.
- 1 gameplay danger color.
- 1 interactable/pickup color.

### Value Separation
Value is more important than hue.

Recommended value hierarchy:

1. Player/enemy/interactable readability.
2. Gameplay terrain top surfaces.
3. Near props.
4. Midground silhouettes.
5. Far background.
6. Sky/backdrop.

### Accent Color Rule
Accent colors should be rare. If every object has an accent, nothing is accented.

---

# 15. Godot Implementation Notes

## Recommended Scene Approach
Use a 3D scene with a 2.5D orthographic camera.

Suggested layout:

```text
LevelRoot
  WorldEnvironment
  DirectionalLight3D
  CameraRig
	Camera3D
  Gameplay
	Terrain
	PlayerSpawn
	Enemies
	Interactables
  Environment
	Foreground
	Midground
	Background
	FarBackground
```

## Material Approach
Start with simple StandardMaterial3D or unshaded/flat-shaded materials.

Recommended:

- Flat color materials.
- Roughness high.
- Minimal metallic.
- Use fog/depth tint for distance.
- Avoid relying on texture complexity.

## Asset Organization
Suggested folders:

```text
/art
  /materials
	/forest
	/mountain
	/desert
	/cave
	/swamp
	/castle
  /environment
	/forest
	/mountain
	/desert
	/cave
	/swamp
	/castle
  /terrain
	/shared
	/forest
	/mountain
	/desert
	/cave
	/swamp
	/castle
```

## Scene Organization
Each biome should eventually have a sample composition scene:

```text
biome_forest_style_test.tscn
biome_mountain_style_test.tscn
biome_desert_style_test.tscn
biome_cave_style_test.tscn
biome_swamp_style_test.tscn
biome_castle_style_test.tscn
```

These are not full levels. They are visual test benches.

---

# 16. Style Validation Checklist

Use this checklist before calling any scene visually acceptable.

## Screenshot Test
Take one screenshot from normal gameplay camera.

Pass conditions:

- Player is readable within 1 second.
- Enemy is readable within 1 second.
- Gameplay path is understandable.
- Background has depth.
- Scene mood matches biome.
- Nothing important is hidden by foreground clutter.

## Grayscale Test
View screenshot in grayscale.

Pass conditions:

- Player still separates from environment.
- Platforms are readable.
- Foreground, midground, and background have different value ranges.

## Silhouette Test
Squint or blur the screenshot.

Pass conditions:

- Large shapes are pleasing.
- Player position remains obvious.
- Scene does not become uniform noise.

## Reuse Test
Ask:

- Can these assets build 3 more screens?
- Are terrain seams manageable?
- Did any asset take too long for its importance?
- Does the biome need more props, or better placement rules?

---

# 17. Production Priorities

## First Production Target
Build the **Forest Biome** first.

Reason:

- It directly matches the reference images.
- It proves the core style.
- It supports dense dressing and modular terrain hiding.
- It gives a strong atmospheric baseline.

## Second Target
Build the **Mountainside Biome** next.

Reason:

- It uses the same layered approach but with more open sky.
- It tests whether the style works without dense forest coverage.
- It introduces stronger rock/platform language.

## Third Target
Choose between **Cave** and **Desert**.

Cave tests dark readability. Desert tests sparse composition. Both are valuable.

## Later Targets
Swamp and Evil Castle should come later because they require stronger visual language discipline:

- Swamp can turn muddy fast.
- Evil Castle can become too dark/noisy fast.

---

# 18. Do / Do Not Summary

## Do
- Use chunky low-poly shapes.
- Build scenes in layers.
- Keep palettes controlled.
- Make terrain modular.
- Hide seams with scatter props.
- Use simple repeated details.
- Keep gameplay objects readable.
- Use fog/depth tint for atmosphere.
- Create biome-specific prop kits.

## Do Not
- Depend on neon/glow as the main style.
- Over-model ordinary props.
- Fill every empty space with clutter.
- Let grass hide the player.
- Let background contrast compete with gameplay.
- Use too many unrelated colors in one biome.
- Make collision as messy as the visual mesh.
- Build one-off terrain pieces for every scene.

---

# 19. Current Style Decision

The project should proceed with the **Layered Low-Poly Diorama** style, beginning with a forest scene based on the provided references.

This style is considered a strong fit because it is:

- Achievable for a solo developer.
- Compatible with modular terrain.
- Flexible across multiple biomes.
- Atmospheric without requiring complex realism.
- More aligned with the desired look than neon/glow-first approaches.

The next art milestone should prove this style through a focused forest slice rather than attempting all biomes at once.
