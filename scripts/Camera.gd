extends Node3D
class_name Camera

@export var mouse_sens: float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
	elif event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		rotation.x = clamp(rotation.x, -0.5, 0.5)
