extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animation = $AnimatedSprite2D

var dirString : String = "left"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
		
		
		
#region Animation code
	# This code takes the last input pressed and sets the variable dirString to it
	if Input.is_action_just_pressed("ui_left"):
		animation.play("leftMove")
		if dirString != "left":
			dirString = "left"


	elif Input.is_action_just_pressed("ui_right"):
		animation.play("rightMove")
		if dirString != "right":
			dirString = "right"
			
	# if the player isn't moving then this code will check dirString to find 
	# the animation it should play
	if direction == 0:
		if dirString == "left":
			animation.play("idleLeft")
		else:
			animation.play("idleRight")
#endregion
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("test"):
		print(velocity)
		print(direction)
		print(dirString[-1])

	move_and_slide()
