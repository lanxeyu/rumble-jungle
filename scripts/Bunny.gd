extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

const speed = 100.0
const jump_velocity = -400.0
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_timer = 5

func _physics_process(delta):
	velocity.x = direction * speed
	velocity.y += gravity * delta
	jump_timer -= delta
	
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1

	# Handle jump.
	if jump_timer < 0 and is_on_floor():
		velocity.y = jump_velocity
		jump_timer = 5

	move_and_slide()
