extends Node3D

@export var initial_level_scene: PackedScene
@export var starts_in_dev_mode: bool = false
@export var dev_mode_toggle_action: StringName = &"dev_mode_toggle"
@export var respawn_action: StringName = &"respawn"
@export var respawn_hold_time: float = 0.5
@export var level_container_path: NodePath
@export var player_path: NodePath
@export var camera_path: NodePath
@export var hud_path: NodePath

var _dev_mode: bool = false
var _level_container: Node3D
var _active_level: Node3D
var _player: Node3D
var _camera: Node
var _hud: Node
var _spawn_position: Vector3 = Vector3.ZERO
var _respawn_hold_timer: float = 0.0


func _ready() -> void:
	_level_container = get_node(level_container_path) as Node3D
	_player = get_node(player_path) as Node3D
	_camera = get_node(camera_path)
	_hud = get_node(hud_path)

	if initial_level_scene != null:
		load_level(initial_level_scene)
	elif _camera.has_method("set_follow_target"):
		_camera.call("set_follow_target", _player)

	_set_dev_mode(starts_in_dev_mode)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(dev_mode_toggle_action):
		_set_dev_mode(not _dev_mode)


func _process(delta: float) -> void:
	_process_respawn_hold(delta)
	if _hud.has_method("set_debug_state"):
		_hud.call("set_debug_state", _dev_mode, _player, _camera, dev_mode_toggle_action)


func load_level(level_scene: PackedScene) -> void:
	if level_scene == null:
		return

	if _active_level != null:
		_active_level.queue_free()
		_active_level = null

	var level_instance: Node = level_scene.instantiate()
	_active_level = level_instance as Node3D
	if _active_level == null:
		level_instance.queue_free()
		return

	_level_container.add_child(_active_level)
	var spawn: Marker3D = _active_level.find_child("PlayerSpawn", true, false) as Marker3D
	if spawn != null:
		_spawn_position = spawn.global_position
		_respawn_player()

	if _camera.has_method("set_follow_target"):
		_camera.call("set_follow_target", _player)


func _set_dev_mode(is_enabled: bool) -> void:
	_dev_mode = is_enabled
	if _camera != null and _camera.has_method("set_dev_mode"):
		_camera.call("set_dev_mode", _dev_mode)
	if _player != null and _player.has_method("set_control_enabled"):
		_player.call("set_control_enabled", not _dev_mode)


func _process_respawn_hold(delta: float) -> void:
	if Input.is_action_pressed(respawn_action):
		_respawn_hold_timer += delta
		if _respawn_hold_timer >= respawn_hold_time:
			_respawn_hold_timer = 0.0
			_respawn_player()
	else:
		_respawn_hold_timer = 0.0


func _respawn_player() -> void:
	if _player == null:
		return

	_player.global_position = _spawn_position
	if _player.has_method("reset_motion_state"):
		_player.call("reset_motion_state")
	if _camera != null and not _dev_mode and _camera.has_method("set_follow_target"):
		_camera.call("set_follow_target", _player)
