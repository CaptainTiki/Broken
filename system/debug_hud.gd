extends CanvasLayer

var _debug_label: Label


func _ready() -> void:
	_debug_label = Label.new()
	_debug_label.name = "DebugReadout"
	_debug_label.position = Vector2(18.0, 16.0)
	_debug_label.add_theme_font_size_override("font_size", 16)
	_debug_label.add_theme_color_override("font_color", Color("#d6fff8"))
	_debug_label.add_theme_color_override("font_shadow_color", Color("#031014"))
	_debug_label.add_theme_constant_override("shadow_offset_x", 2)
	_debug_label.add_theme_constant_override("shadow_offset_y", 2)
	add_child(_debug_label)


func set_debug_state(dev_mode: bool, player: Node3D, camera: Node, dev_mode_toggle_action: StringName) -> void:
	var player_position: Vector3 = Vector3.ZERO
	var camera_position: Vector3 = Vector3.ZERO

	if player != null:
		player_position = player.global_position
	if camera is Node3D:
		camera_position = (camera as Node3D).global_position

	var lines: PackedStringArray = [
		"Mode: " + ("DEV" if dev_mode else "GAME"),
		String(dev_mode_toggle_action) + ": Toggle dev camera",
		"move_* actions: Move camera in dev",
		"Player: " + _format_vector(player_position),
		"Camera: " + _format_vector(camera_position),
	]
	if camera != null and camera.has_method("get_camera_mode_label"):
		lines.insert(2, "Camera A/B: " + camera.call("get_camera_mode_label") + " | C toggles")
	if player != null and player.has_method("get_debug_lines"):
		lines.append_array(player.call("get_debug_lines") as PackedStringArray)
	_debug_label.text = "\n".join(lines)


func _format_vector(value: Vector3) -> String:
	return "(%0.2f, %0.2f, %0.2f)" % [value.x, value.y, value.z]
