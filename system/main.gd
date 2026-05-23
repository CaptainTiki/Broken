extends Node3D

@export var starts_in_dev_mode: bool = false
@export var dev_mode_toggle_action: StringName = &"dev_mode_toggle"
@export var player_path: NodePath
@export var camera_path: NodePath
@export var hud_path: NodePath

var _dev_mode: bool = false
var _player: Node3D
var _camera: Node
var _hud: Node


func _ready() -> void:
	_player = get_node(player_path) as Node3D
	_camera = get_node(camera_path)
	_hud = get_node(hud_path)

	if _camera.has_method("set_follow_target"):
		_camera.call("set_follow_target", _player)

	_set_dev_mode(starts_in_dev_mode)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(dev_mode_toggle_action):
		_set_dev_mode(not _dev_mode)


func _process(_delta: float) -> void:
	if _hud.has_method("set_debug_state"):
		_hud.call("set_debug_state", _dev_mode, _player, _camera, dev_mode_toggle_action)


func _set_dev_mode(is_enabled: bool) -> void:
	_dev_mode = is_enabled
	if _camera != null and _camera.has_method("set_dev_mode"):
		_camera.call("set_dev_mode", _dev_mode)
	if _player != null and _player.has_method("set_control_enabled"):
		_player.call("set_control_enabled", not _dev_mode)
