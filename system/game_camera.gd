extends Camera3D

@export var game_target_offset: Vector3 = Vector3(0.0, 3.5, 13.5)
@export var game_orthographic_size: float = 7.5
@export var game_rotation_degrees: Vector3 = Vector3(-30.0, 0.0, 0.0)
@export var follow_smoothing: float = 7.5
@export var dev_pan_speed: float = 9.0
@export var dev_fast_multiplier: float = 2.2
@export var move_left_action: StringName = &"move_left"
@export var move_right_action: StringName = &"move_right"
@export var move_up_action: StringName = &"move_up"
@export var move_down_action: StringName = &"move_down"
@export var move_fast_action: StringName = &"dash"

var _dev_mode: bool = false
var _follow_target: Node3D


func _ready() -> void:
	make_current()
	projection = Camera3D.PROJECTION_ORTHOGONAL
	_apply_game_framing()


func set_follow_target(target: Node3D) -> void:
	_follow_target = target
	if _follow_target != null and not _dev_mode:
		_focus_game_camera()


func set_dev_mode(is_enabled: bool) -> void:
	_dev_mode = is_enabled
	if not _dev_mode and _follow_target != null:
		_focus_game_camera()


func is_dev_mode() -> bool:
	return _dev_mode


func _process(delta: float) -> void:
	if _dev_mode:
		_process_dev_pan(delta)


func _physics_process(delta: float) -> void:
	if not _dev_mode:
		_process_follow(delta)


func _process_dev_pan(delta: float) -> void:
	var movement: Vector3 = Vector3.ZERO
	movement.x = Input.get_axis(move_left_action, move_right_action)
	movement.y = Input.get_axis(move_down_action, move_up_action)

	if movement.length_squared() <= 0.0:
		return

	var speed: float = dev_pan_speed
	if Input.is_action_pressed(move_fast_action):
		speed *= dev_fast_multiplier

	global_position += movement.normalized() * speed * delta


func _process_follow(delta: float) -> void:
	if _follow_target == null:
		return

	var target_position: Vector3 = _get_follow_position()
	var weight: float = 1.0 - exp(-follow_smoothing * delta)
	global_position = global_position.lerp(target_position, weight)


func _focus_game_camera() -> void:
	_apply_game_framing()
	global_position = _get_follow_position()


func _apply_game_framing() -> void:
	size = game_orthographic_size
	rotation_degrees = game_rotation_degrees


func _get_follow_position() -> Vector3:
	return _follow_target.global_position + game_target_offset
