extends CharacterBody3D

@export var speed = 10
@export var fall_acceleration = 75
@export var jump_force = 20  

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		basis = basis.slerp(Basis.looking_at(direction), delta * 10)  

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed


	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = jump_force


	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta

	velocity = target_velocity
	move_and_slide()
