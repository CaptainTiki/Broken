extends CharacterBody3D

@export var move_left_action: StringName = &"move_left"
@export var move_right_action: StringName = &"move_right"
@export var jump_action: StringName = &"jump"
@export var move_speed: float = 5.4
@export var jump_velocity: float = 6.8
@export var locked_z_position: float = 0.0

var _gravity: float = 9.8
var _control_enabled: bool = true


func _ready() -> void:
	var gravity_setting: Variant = ProjectSettings.get_setting("physics/3d/default_gravity")
	_gravity = float(gravity_setting)
	global_position.z = locked_z_position


func _physics_process(delta: float) -> void:
	var move_axis: float = 0.0
	if _control_enabled:
		move_axis = Input.get_axis(move_left_action, move_right_action)

	velocity.x = move_axis * move_speed
	velocity.z = 0.0

	if is_on_floor():
		if _control_enabled and Input.is_action_just_pressed(jump_action):
			velocity.y = jump_velocity
	else:
		velocity.y -= _gravity * delta

	move_and_slide()
	global_position.z = locked_z_position


func set_control_enabled(is_enabled: bool) -> void:
	_control_enabled = is_enabled


func get_debug_lines() -> PackedStringArray:
	return [
		"Player Input: " + ("ON" if _control_enabled else "OFF"),
		"Grounded: " + str(is_on_floor()),
		"Velocity: " + _format_vector(velocity),
	]


func _format_vector(value: Vector3) -> String:
	return "(%0.2f, %0.2f, %0.2f)" % [value.x, value.y, value.z]
