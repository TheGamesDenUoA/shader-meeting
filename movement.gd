extends Node
class_name Movement

@onready var char_body: CharacterBody3D = get_parent()
@export var camera_rot: Node3D
@export var camera: Camera3D

var SPEED := 10

var camera_move_event: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	camera_move(delta)
	
	var input_dir := GlobalInput.keyboard_vector()
	if input_dir == Vector2.ZERO:
		input_dir = GlobalInput.move_joystick()
	
	var direction: Vector3 = (camera_rot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		char_body.velocity.x = direction.x * SPEED
		char_body.velocity.z = direction.z * SPEED
	else:
		char_body.velocity.x = move_toward(char_body.velocity.x, 0, SPEED)
		char_body.velocity.z = move_toward(char_body.velocity.z, 0, SPEED)
	char_body.velocity.y = char_body.get_gravity().y
	char_body.move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_move_event = event.relative * GlobalInput.MOUSE_SENSITIVITY

func camera_move(delta: float):
	var move := GlobalInput.camera_joystick() 
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and move == Vector2.ZERO:
		move = camera_move_event
	camera_move_event = Vector2.ZERO
	camera.global_rotation.x -= move.y*delta
	camera.global_rotation.x = clampf(camera.global_rotation.x, -1.0, 1.0)
	camera_rot.global_rotation.y -= move.x*delta
