extends Node3D

const SKY_SHADER := preload("res://scripts/dusty_sky.gdshader")

@export var camera_path: NodePath

var _camera: Camera3D
var _terrain_material: StandardMaterial3D
var _terrain_dark_material: StandardMaterial3D
var _platform_top_material: StandardMaterial3D
var _platform_side_material: StandardMaterial3D
var _platform_edge_material: StandardMaterial3D
var _rock_material: StandardMaterial3D
var _rock_shadow_material: StandardMaterial3D
var _pillar_material: StandardMaterial3D
var _mountain_far_material: StandardMaterial3D
var _mountain_near_material: StandardMaterial3D
var _dust_material: StandardMaterial3D

func _ready() -> void:
	_camera = get_node(camera_path) as Camera3D
	RenderingServer.set_default_clear_color(Color("#8f6b27"))
	_build_materials()
	_build_environment()
	_build_sky()
	_build_mountains()
	_build_terrain()
	_build_play_platforms()
	_build_background_rocks()
	_build_pillars()
	_build_foreground_stones()
	_add_path_markers()


func _build_materials() -> void:
	_terrain_material = _make_material(Color("#8b6a39"), 0.0, Color.BLACK)
	_terrain_dark_material = _make_material(Color("#5f472d"), 0.0, Color.BLACK)
	_platform_top_material = _make_material(Color("#9b7741"), 0.0, Color.BLACK)
	_platform_side_material = _make_material(Color("#62482e"), 0.0, Color.BLACK)
	_platform_edge_material = _make_material(Color("#c09a55"), 0.0, Color.BLACK)
	_rock_material = _make_material(Color("#756044"), 0.0, Color.BLACK)
	_rock_shadow_material = _make_material(Color("#423222"), 0.0, Color.BLACK)
	_pillar_material = _make_material(Color("#695338"), 0.0, Color.BLACK)
	_mountain_far_material = _make_material(Color("#655132"), 0.0, Color.BLACK)
	_mountain_near_material = _make_material(Color("#3f3326"), 0.0, Color.BLACK)
	_dust_material = _make_material(Color("#d0a34a", 0.28), 0.0, Color.BLACK)
	_dust_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_dust_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED


func _build_environment() -> void:
	var world := WorldEnvironment.new()
	world.name = "DustWorldGrade"
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#8f6b27")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#b98f4b")
	environment.ambient_light_energy = 0.82
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.adjustment_enabled = true
	environment.adjustment_brightness = 0.94
	environment.adjustment_contrast = 1.16
	environment.adjustment_saturation = 0.78
	world.environment = environment
	add_child(world)

	var sun := DirectionalLight3D.new()
	sun.name = "LowDustSun"
	sun.light_color = Color("#ffc66a")
	sun.light_energy = 2.2
	sun.rotation_degrees = Vector3(-33.0, -54.0, 0.0)
	add_child(sun)

	var fill := DirectionalLight3D.new()
	fill.name = "WarmBounce"
	fill.light_color = Color("#b98244")
	fill.light_energy = 0.55
	fill.rotation_degrees = Vector3(-68.0, 38.0, 0.0)
	add_child(fill)


func _build_sky() -> void:
	var sky := MeshInstance3D.new()
	sky.name = "DirtyYellowDustSky"
	var mesh := QuadMesh.new()
	mesh.size = Vector2(80.0, 42.0)
	sky.mesh = mesh
	sky.position = Vector3(0.0, 7.0, -38.0)
	var material := ShaderMaterial.new()
	material.shader = SKY_SHADER
	sky.material_override = material
	add_child(sky)

	for index in 4:
		var haze := MeshInstance3D.new()
		haze.name = "HorizontalDustHaze"
		var haze_mesh := QuadMesh.new()
		haze_mesh.size = Vector2(76.0, 2.4 + index * 0.35)
		haze.mesh = haze_mesh
		haze.material_override = _dust_material
		haze.position = Vector3(0.0, 1.25 + index * 0.95, -32.0 + index * 0.2)
		add_child(haze)


func _build_mountains() -> void:
	_add_mountain_layer(
		"FarMountainHorizon",
		[-42.0, -34.0, -26.0, -17.5, -8.0, 2.0, 11.0, 21.5, 31.0, 42.0],
		[3.3, 4.5, 2.8, 5.2, 3.4, 6.0, 3.2, 4.8, 2.9],
		-28.0,
		-1.6,
		_mountain_far_material
	)
	_add_mountain_layer(
		"NearBrokenRidge",
		[-38.0, -28.0, -19.0, -10.5, -2.0, 7.5, 16.5, 27.0, 38.0],
		[2.4, 3.8, 2.6, 4.5, 3.2, 4.1, 2.7, 3.6],
		-22.0,
		-2.2,
		_mountain_near_material
	)


func _build_terrain() -> void:
	var ground := MeshInstance3D.new()
	ground.name = "LowerDustBed"
	var mesh := PlaneMesh.new()
	mesh.size = Vector2(54.0, 34.0)
	ground.mesh = mesh
	ground.material_override = _terrain_material
	ground.position = Vector3(0.0, -3.85, -4.5)
	add_child(ground)

	var rng := RandomNumberGenerator.new()
	rng.seed = 1776
	for index in 52:
		var patch := MeshInstance3D.new()
		patch.name = "DryTerrainPatch"
		var patch_mesh := BoxMesh.new()
		patch_mesh.size = Vector3(rng.randf_range(1.2, 4.0), 0.025, rng.randf_range(0.45, 1.6))
		patch.mesh = patch_mesh
		patch.material_override = _terrain_dark_material if index % 3 == 0 else _rock_material
		patch.position = Vector3(rng.randf_range(-25.0, 25.0), -3.82, rng.randf_range(-17.0, 10.0))
		patch.rotation_degrees.y = rng.randf_range(-38.0, 38.0)
		add_child(patch)


func _build_play_platforms() -> void:
	var platforms: Array = _platform_data()
	for data: Array in platforms:
		_add_platform(float(data[0]), float(data[1]), float(data[2]), float(data[3]), float(data[4]), float(data[5]))

	var rng := RandomNumberGenerator.new()
	rng.seed = 428
	for index in 42:
		var data: Array = platforms[index % platforms.size()]
		var x := float(data[0]) + rng.randf_range(float(data[1]) * -0.43, float(data[1]) * 0.43)
		var y := float(data[2]) + 0.19
		var z := float(data[4]) + rng.randf_range(float(data[5]) * -0.34, float(data[5]) * 0.34)
		var scale := rng.randf_range(0.16, 0.48)
		_add_rock(Vector3(x, y, z), Vector3(scale * 1.8, scale * 0.42, scale * 1.2), rng.randf_range(-55.0, 55.0), _terrain_dark_material if index % 5 == 0 else _rock_material)


func _build_background_rocks() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 311
	for index in 24:
		var x := rng.randf_range(-28.0, 28.0)
		var z := rng.randf_range(-19.0, -9.0)
		var scale := rng.randf_range(0.8, 2.4)
		_add_rock(Vector3(x, -2.05 + scale * 0.12, z), Vector3(scale * rng.randf_range(1.0, 1.8), scale * rng.randf_range(0.7, 1.5), scale * rng.randf_range(0.7, 1.4)), rng.randf_range(-45.0, 45.0), _rock_material)


func _build_pillars() -> void:
	var pillar_data := [
		[Vector3(-19.0, 0.1, -14.0), 1.45, 5.6],
		[Vector3(-12.0, -0.35, -11.7), 0.9, 4.4],
		[Vector3(14.0, 0.25, -13.0), 1.25, 5.8],
		[Vector3(21.0, -0.15, -16.2), 0.85, 4.8],
		[Vector3(5.5, -0.45, -17.0), 0.7, 3.9],
	]

	for data in pillar_data:
		var position: Vector3 = data[0]
		var radius: float = data[1]
		var height: float = data[2]
		var pillar := MeshInstance3D.new()
		pillar.name = "WeatheredRockPillar"
		var mesh := CylinderMesh.new()
		mesh.top_radius = radius * 0.72
		mesh.bottom_radius = radius
		mesh.height = height
		mesh.radial_segments = 7
		pillar.mesh = mesh
		pillar.material_override = _pillar_material
		pillar.position = position
		pillar.rotation_degrees = Vector3(randf_range(-2.0, 2.0), randf_range(-18.0, 18.0), randf_range(-2.0, 2.0))
		add_child(pillar)


func _build_foreground_stones() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 919
	for index in 34:
		var x := rng.randf_range(-25.0, 25.0)
		var z := rng.randf_range(-4.5, 11.0)
		if absf(x) < 3.3 and z > -1.5:
			x += 5.0 * signf(x if x != 0.0 else 1.0)
		var scale := rng.randf_range(0.28, 1.15)
		_add_rock(Vector3(x, -3.02 + scale * 0.12, z), Vector3(scale * 1.7, scale * 0.75, scale * 1.15), rng.randf_range(-70.0, 70.0), _rock_shadow_material if index % 4 == 0 else _rock_material)


func _add_path_markers() -> void:
	for data in _platform_data():
		var center_x := float(data[0])
		var width := float(data[1])
		var top_y := float(data[2])
		var z := float(data[4])
		for index in max(2, int(width / 2.4)):
			var marker := MeshInstance3D.new()
			marker.name = "ReadableRunSurfaceStone"
			var mesh := BoxMesh.new()
			mesh.size = Vector3(0.82, 0.08, 0.34)
			marker.mesh = mesh
			marker.material_override = _terrain_dark_material
			marker.position = Vector3(center_x - width * 0.36 + index * 2.25, top_y + 0.16, z + sin(index * 0.8 + center_x) * 0.34)
			marker.rotation_degrees.y = -12.0 + index * 7.0
			add_child(marker)


func _add_platform(center_x: float, width: float, top_y: float, height: float, z: float, depth: float) -> void:
	var body := StaticBody3D.new()
	body.name = "PlayableRockPlatform"
	body.position = Vector3(center_x, top_y - height * 0.5, z)
	add_child(body)

	var collision := CollisionShape3D.new()
	collision.name = "PlatformCollision"
	var shape := BoxShape3D.new()
	shape.size = Vector3(width, height, depth)
	collision.shape = shape
	body.add_child(collision)

	var side := MeshInstance3D.new()
	side.name = "RockPlatformCliffFace"
	var side_mesh := BoxMesh.new()
	side_mesh.size = Vector3(width, height, depth)
	side.mesh = side_mesh
	side.material_override = _platform_side_material
	body.add_child(side)

	var top := MeshInstance3D.new()
	top.name = "FlatDustyRunTop"
	var top_mesh := BoxMesh.new()
	top_mesh.size = Vector3(width + 0.18, 0.28, depth + 0.12)
	top.mesh = top_mesh
	top.material_override = _platform_top_material
	top.position = Vector3(0.0, height * 0.5 + 0.02, 0.0)
	body.add_child(top)

	var front_lip := MeshInstance3D.new()
	front_lip.name = "SunBakedPlatformLip"
	var lip_mesh := BoxMesh.new()
	lip_mesh.size = Vector3(width + 0.28, 0.12, 0.16)
	front_lip.mesh = lip_mesh
	front_lip.material_override = _platform_edge_material
	front_lip.position = Vector3(0.0, height * 0.5 + 0.14, depth * 0.5 + 0.08)
	body.add_child(front_lip)

	var rng := RandomNumberGenerator.new()
	rng.seed = int((center_x + 64.0) * 100.0)
	for index in int(width * 0.75):
		var chip := MeshInstance3D.new()
		chip.name = "JaggedPlatformBreak"
		var chip_mesh := BoxMesh.new()
		chip_mesh.size = Vector3(rng.randf_range(0.18, 0.58), rng.randf_range(0.25, 0.82), rng.randf_range(0.12, 0.32))
		chip.mesh = chip_mesh
		chip.material_override = _rock_shadow_material
		var side_sign := -1.0 if index % 2 == 0 else 1.0
		chip.position = Vector3(rng.randf_range(width * -0.48, width * 0.48), rng.randf_range(height * -0.35, height * 0.32), side_sign * (depth * 0.5 + 0.08))
		chip.rotation_degrees = Vector3(rng.randf_range(-8.0, 8.0), rng.randf_range(-32.0, 32.0), rng.randf_range(-9.0, 9.0))
		body.add_child(chip)


func _platform_data() -> Array:
	return [
		[-17.0, 8.4, -1.42, 2.35, -0.6, 4.8],
		[-7.2, 6.2, -0.72, 3.05, 0.0, 4.3],
		[1.8, 6.8, -1.22, 2.45, -0.35, 4.5],
		[10.0, 5.6, -0.18, 3.55, 0.1, 4.0],
		[18.7, 7.2, -1.48, 2.2, -0.65, 4.8],
		[-22.8, 4.4, 0.15, 3.7, -1.7, 3.4],
		[24.8, 4.6, -0.1, 3.45, -1.5, 3.5],
	]


func _add_rock(position: Vector3, size: Vector3, rotation_y: float, material: Material) -> void:
	var rock := MeshInstance3D.new()
	rock.name = "AngularDustRock"
	var mesh := BoxMesh.new()
	mesh.size = size
	rock.mesh = mesh
	rock.material_override = material
	rock.position = position
	rock.rotation_degrees = Vector3(randf_range(-7.0, 7.0), rotation_y, randf_range(-5.0, 5.0))
	add_child(rock)


func _add_mountain_layer(layer_name: String, xs: Array, heights: Array, z: float, base_y: float, material: Material) -> void:
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var indices := PackedInt32Array()

	for index in heights.size():
		var left := float(xs[index])
		var right := float(xs[index + 1])
		var mid := (left + right) * 0.5
		var height := float(heights[index])
		var start := vertices.size()
		vertices.append(Vector3(left, base_y, z))
		vertices.append(Vector3(mid, base_y + height, z))
		vertices.append(Vector3(right, base_y, z))
		normals.append(Vector3.BACK)
		normals.append(Vector3.BACK)
		normals.append(Vector3.BACK)
		indices.append_array([start, start + 1, start + 2])

	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices

	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	var layer := MeshInstance3D.new()
	layer.name = layer_name
	layer.mesh = mesh
	layer.material_override = material
	add_child(layer)


func _make_material(albedo: Color, emission_energy: float, emission: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = albedo
	material.emission_enabled = emission_energy > 0.0
	material.emission = emission
	material.emission_energy_multiplier = emission_energy
	material.roughness = 0.96
	material.metallic = 0.0
	return material
