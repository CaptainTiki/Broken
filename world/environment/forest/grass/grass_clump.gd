@tool
extends MultiMeshInstance3D
class_name GrassClump

## Number of grass blades in this clump
@export var blade_count: int = 4:
	set(value):
		blade_count = clamp(value, 1, 8)
		if is_node_ready():
			_regenerate()

## Base height of the blades (will be slightly randomized)
@export var base_height: float = 0.85

## How much random rotation around Y
@export var rotation_variation: float = 1.0  # radians

## How much random scale variation
@export var scale_variation: float = 0.15

## Slight random offset from center
@export var position_radius: float = 0.25

@export var use_light_foliage: bool = false:
	set(value):
		use_light_foliage = value
		_apply_material()

var _grass_material: Material
var _light_grass_material: Material


func _ready() -> void:
	_load_materials()
	_regenerate()


func _load_materials() -> void:
	# Try to load the same materials used in the existing forest dressing kit
	_grass_material = load("res://art/materials/forest/forest_foliage.tres")
	_light_grass_material = load("res://art/materials/forest/forest_foliage_light.tres")
	
	if not _grass_material:
		# Fallback to the ones embedded in the kit if shared ones aren't ready
		push_warning("Could not load shared grass materials, using fallback")
		_grass_material = load("res://world/environment/forest/forest_dressing_kit.tscn::StandardMaterial3D_grass")
		_light_grass_material = load("res://world/environment/forest/forest_dressing_kit.tscn::StandardMaterial3D_foliage_light")


func _apply_material() -> void:
	if not multimesh:
		return
	
	var mat := _light_grass_material if use_light_foliage else _grass_material
	if mat:
		multimesh.mesh.surface_set_material(0, mat)


func _regenerate() -> void:
	if not multimesh:
		multimesh = MultiMesh.new()
		multimesh.transform_format = MultiMesh.TRANSFORM_3D
		multimesh.use_custom_data = false
		multimesh.use_colors = false
	
	# Create the blade mesh (matching current style)
	var blade_mesh := BoxMesh.new()
	blade_mesh.size = Vector3(0.12, base_height, 0.08)
	multimesh.mesh = blade_mesh
	
	_apply_material()
	
	multimesh.instance_count = blade_count
	
	var rng := RandomNumberGenerator.new()
	# Use a stable seed per instance so it doesn't change every frame in editor
	rng.seed = hash(get_instance_id()) + blade_count
	
	for i in blade_count:
		var t := Transform3D.IDENTITY
		
		# Random position within a small radius
		var offset := Vector3(
			rng.randf_range(-position_radius, position_radius),
			0.0,
			rng.randf_range(-position_radius, position_radius)
		)
		t.origin = offset
		
		# Random rotation around Y
		var rot := rng.randf_range(-rotation_variation, rotation_variation)
		t.basis = Basis(Vector3.UP, rot)
		
		# Slight random scale (mainly in height)
		var s := 1.0 + rng.randf_range(-scale_variation, scale_variation)
		t = t.scaled(Vector3(1.0, s, 1.0))
		
		# Slight random lean
		var lean_x := rng.randf_range(-0.15, 0.15)
		var lean_z := rng.randf_range(-0.15, 0.15)
		t.basis = t.basis.rotated(Vector3.RIGHT, lean_x)
		t.basis = t.basis.rotated(Vector3.FORWARD, lean_z)
		
		multimesh.set_instance_transform(i, t)
