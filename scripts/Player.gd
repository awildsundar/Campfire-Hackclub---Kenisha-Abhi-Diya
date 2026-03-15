extends CharacterBody3D
class_name Player

@onready var raycast: RayCast3D = $CameraController/Camera3D/RayCast3D
@onready var animation: Sprite2D = $Sprite2D
@onready var ore_count_display: Label = $Control/Label
@onready var interact_indicator: CenterContainer = $InteractIndicator
@onready var footsteps: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var rock: AudioStreamPlayer3D = $AudioStreamPlayer3D2

var base_speed : float = 5.0
var base_strength : float = 50.0

var ore: int = 0
var money: float

var direction: Vector3

func _ready() -> void:
	animation.texture.current_frame = 0
	animation.texture.pause = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
	elif event.is_action_pressed("interact"):
		interact()

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _physics_process(delta: float) -> void:
	if raycast.is_colliding() && raycast.get_collider() is BaseInteractable:
		interact_indicator.show()
	else:
		interact_indicator.hide()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction:
		velocity.x = direction.x * PlayerAutoloads.speed
		velocity.z = direction.z * PlayerAutoloads.speed
	else:
		velocity.x = move_toward(velocity.x, 0, PlayerAutoloads.speed)
		velocity.z = move_toward(velocity.z, 0, PlayerAutoloads.speed)
	
	if velocity:
		footsteps.play()
	else:
		footsteps.stop()

	move_and_slide()

func interact() -> void:
	animation.texture.current_frame = 0
	animation.texture.pause = false
	if animation.frame >= 3:
		animation.texture.set_current_frame(0)
		animation.texture.pause = true
	if raycast.is_colliding():
		var body: Object = raycast.get_collider()
		if body is BaseInteractable:
			body.interact(self)
			if body is OreInteractable:
				rock.play()
	
