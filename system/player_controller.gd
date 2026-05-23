extends CharacterBody3D

@export var move_left_action: StringName = &"move_left"
@export var move_right_action: StringName = &"move_right"
@export var jump_action: StringName = &"jump"
@export var max_move_speed: float = 7.0
@export var ground_acceleration: float = 62.0
@export var ground_deceleration: float = 72.0
@export var air_acceleration: float = 38.0
@export var air_deceleration: float = 18.0
@export var jump_gravity: float = 28.0
@export var fall_gravity: float = 42.0
@export var jump_cut_gravity: float = 100.0
@export var jump_cut_velocity_multiplier: float = 0.15
@export var jump_velocity: float = 11.2
@export var air_jump_velocity_multiplier: float = 0.85
@export var max_jump_count: int = 2
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.12
@export var dash_action: StringName = &"dash"
@export var dash_speed: float = 18.75
@export var dash_duration: float = 0.16
@export var dash_cooldown: float = 0.28
@export var locked_z_position: float = 0.0

var _control_enabled: bool = true
var _jumps_used: int = 0
var _last_faced_direction: float = 1.0
var _coyote_timer: float = 0.0
var _jump_buffer_timer: float = 0.0
var _dash_timer: float = 0.0
var _dash_cooldown_timer: float = 0.0
var _dash_available: bool = true
var _dash_direction: float = 1.0
var _jump_cut_active: bool = false


func _ready() -> void:
	global_position.z = locked_z_position


func _physics_process(delta: float) -> void:
	var move_axis: float = 0.0
	if _control_enabled:
		move_axis = Input.get_axis(move_left_action, move_right_action)

	_update_timers(delta)
	_update_grounded_state()

	if _control_enabled:
		if Input.is_action_just_pressed(jump_action):
			_jump_buffer_timer = jump_buffer_time
		if Input.is_action_just_released(jump_action):
			_apply_jump_cut()
		if Input.is_action_just_pressed(dash_action):
			_try_start_dash(move_axis)

	velocity.z = 0.0
	if absf(move_axis) > 0.0:
		_last_faced_direction = signf(move_axis)

	if _dash_timer > 0.0:
		velocity.x = _dash_direction * dash_speed
		velocity.y = 0.0
	else:
		_apply_horizontal_movement(move_axis, delta)
		_apply_jump()
		if not is_on_floor():
			_apply_gravity(delta)

	move_and_slide()
	global_position.z = locked_z_position


func set_control_enabled(is_enabled: bool) -> void:
	_control_enabled = is_enabled
	if not _control_enabled:
		_jump_buffer_timer = 0.0


func reset_motion_state() -> void:
	velocity = Vector3.ZERO
	_jumps_used = 0
	_coyote_timer = 0.0
	_jump_buffer_timer = 0.0
	_dash_timer = 0.0
	_dash_cooldown_timer = 0.0
	_dash_available = true
	_dash_direction = _last_faced_direction
	_jump_cut_active = false
	global_position.z = locked_z_position


func _update_timers(delta: float) -> void:
	_coyote_timer = maxf(_coyote_timer - delta, 0.0)
	_jump_buffer_timer = maxf(_jump_buffer_timer - delta, 0.0)
	_dash_timer = maxf(_dash_timer - delta, 0.0)
	_dash_cooldown_timer = maxf(_dash_cooldown_timer - delta, 0.0)


func _update_grounded_state() -> void:
	if is_on_floor():
		_coyote_timer = coyote_time
		_jumps_used = 0
		_jump_cut_active = false
		if _dash_cooldown_timer <= 0.0:
			_dash_available = true
	elif _coyote_timer <= 0.0 and _jumps_used == 0:
		_jumps_used = 1


func _apply_horizontal_movement(move_axis: float, delta: float) -> void:
	var target_speed: float = move_axis * max_move_speed
	var rate: float = ground_acceleration

	if is_on_floor():
		if absf(move_axis) <= 0.0:
			rate = ground_deceleration
	else:
		rate = air_acceleration
		if absf(move_axis) <= 0.0:
			rate = air_deceleration

	velocity.x = move_toward(velocity.x, target_speed, rate * delta)


func _apply_jump() -> void:
	if _jump_buffer_timer <= 0.0:
		return

	var can_ground_jump: bool = is_on_floor() or (_coyote_timer > 0.0 and _jumps_used == 0)
	var can_air_jump: bool = _jumps_used < max_jump_count and not can_ground_jump
	if not can_ground_jump and not can_air_jump:
		return

	velocity.y = jump_velocity if can_ground_jump else jump_velocity * air_jump_velocity_multiplier
	_jump_buffer_timer = 0.0
	_coyote_timer = 0.0
	_jump_cut_active = false
	_jumps_used = 1 if can_ground_jump else _jumps_used + 1


func _apply_jump_cut() -> void:
	if velocity.y <= 0.0:
		return

	velocity.y *= jump_cut_velocity_multiplier
	_jump_cut_active = true


func _apply_gravity(delta: float) -> void:
	var active_gravity: float = jump_gravity

	if velocity.y <= 0.0:
		active_gravity = fall_gravity
		_jump_cut_active = false
	elif _jump_cut_active:
		active_gravity = jump_cut_gravity

	velocity.y -= active_gravity * delta


func _try_start_dash(move_axis: float) -> void:
	if not _dash_available or _dash_cooldown_timer > 0.0:
		return

	_dash_direction = signf(move_axis) if absf(move_axis) > 0.0 else _last_faced_direction
	_dash_timer = dash_duration
	_dash_cooldown_timer = dash_cooldown
	_dash_available = false
	_jump_cut_active = false


func get_debug_lines() -> PackedStringArray:
	return [
		"Player Input: " + ("ON" if _control_enabled else "OFF"),
		"Grounded: " + str(is_on_floor()),
		"Velocity: " + _format_vector(velocity),
		"Jumps Used: " + str(_jumps_used) + " / " + str(max_jump_count),
		"Coyote: %0.2f" % _coyote_timer,
		"Jump Buffer: %0.2f" % _jump_buffer_timer,
		"Jump Cut: " + str(_jump_cut_active),
		"Dash Timer: %0.2f" % _dash_timer,
		"Dash Cooldown: %0.2f" % _dash_cooldown_timer,
		"Dash Available: " + str(_dash_available),
	]


func _format_vector(value: Vector3) -> String:
	return "(%0.2f, %0.2f, %0.2f)" % [value.x, value.y, value.z]
