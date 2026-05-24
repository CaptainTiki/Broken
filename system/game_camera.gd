extends Camera3D

@export var game_target_offset: Vector3 = Vector3(0.0, 6.5, 15.5)
@export var game_orthographic_size: float = 20
@export var perspective_target_offset: Vector3 = Vector3(0.0, 7.5, 28.0)
@export var perspective_field_of_view: float = 20.0
@export var starts_in_perspective_mode: bool = true
@export var camera_mode_toggle_action: StringName = &"camera_mode_toggle"
@export var game_rotation_degrees: Vector3 = Vector3(-7.5, 0.0, 0.0)
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
var _uses_perspective_mode: bool = false


func _ready() -> void:
	make_current()
	_uses_perspective_mode = starts_in_perspective_mode
	_apply_game_framing()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(camera_mode_toggle_action):
		_uses_perspective_mode = not _uses_perspective_mode
		_apply_game_framing()
		if _follow_target != null and not _dev_mode:
			_focus_game_camera()


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


func get_camera_mode_label() -> String:
	return "Perspective %0.0f FOV" % perspective_field_of_view if _uses_perspective_mode else "Orthographic"


func set_perspective_mode(is_enabled: bool) -> void:
	_uses_perspective_mode = is_enabled
	_apply_game_framing()
	if _follow_target != null and not _dev_mode:
		_focus_game_camera()


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
	if _uses_perspective_mode:
		projection = Camera3D.PROJECTION_PERSPECTIVE
		fov = perspective_field_of_view
	else:
		projection = Camera3D.PROJECTION_ORTHOGONAL
		size = game_orthographic_size
	rotation_degrees = game_rotation_degrees


func _get_follow_position() -> Vector3:
	var active_offset: Vector3 = perspective_target_offset if _uses_perspective_mode else game_target_offset
	return _follow_target.global_position + active_offset
