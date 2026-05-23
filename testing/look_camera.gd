extends Camera3D

@export var pan_speed := 8.0
@export var fast_multiplier := 2.4
@export var orbit_sensitivity := 0.006
@export var zoom_speed := 1.0
@export var min_ortho_size := 5.0
@export var max_ortho_size := 22.0

var _rotating := false

func _ready() -> void:
	make_current()
	projection = Camera3D.PROJECTION_ORTHOGONAL


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_rotating = event.pressed
		elif event.pressed and event.button_index == MOUSE_BUTTON_WHEEL_UP:
			size = maxf(min_ortho_size, size - zoom_speed)
		elif event.pressed and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			size = minf(max_ortho_size, size + zoom_speed)
	elif event is InputEventMouseMotion and _rotating:
		rotate_y(-event.relative.x * orbit_sensitivity)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * orbit_sensitivity)


func _process(delta: float) -> void:
	var speed := pan_speed * (fast_multiplier if Input.is_key_pressed(KEY_SHIFT) else 1.0)
	var movement := Vector3.ZERO
	movement.x = Input.get_axis("ui_left", "ui_right")
	movement.y = Input.get_axis("ui_down", "ui_up")
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_Q):
		movement.z -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_E):
		movement.z += 1.0

	if movement.length_squared() > 0.0:
		position += global_transform.basis * movement.normalized() * speed * delta
