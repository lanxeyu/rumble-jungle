extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

var speed = 100.0
var jump_velocity = -400.0
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	velocity.x = direction * speed
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("action_up") and is_on_floor():
		velocity.y = jump_velocity

	if ray_cast_right.is_colliding():
		if !(ray_cast_right.get_collider() is CharacterBody2D):
			print(ray_cast_right.get_collider())
			direction = -1
	if ray_cast_left.is_colliding():
		if !(ray_cast_left.get_collider() is CharacterBody2D):
			print(ray_cast_left.get_collider())
			direction = -1

	move_and_slide()
	
	# Handle animations
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	

	
	
