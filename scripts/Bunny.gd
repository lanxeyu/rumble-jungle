extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_timer = 5

func _process(delta):

	jump_timer -= delta
	
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1

	position.x += direction * SPEED * delta


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if jump_timer < 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_timer = 5



	move_and_slide()

