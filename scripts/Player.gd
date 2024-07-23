extends CharacterBody2D


const SPEED = 80.0*45*1.4
const JUMP_VELOCITY = -1900.0
const MAX_SPEED = 900
const FRICTION = 0.6
const CHANGE_DIRECTION_SPEED = 2.0
const MAX_WALK_SPEED = 700
const CUT_OFF_JUMP_VELOCITY = -1000
@onready var timer = $JumpFXTimer
var play_jump_fx := true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 6
@onready var jump_sfx = $JumpSFX
@export var default_respawn_point := Vector2(-300,60)
var respawn_point := default_respawn_point

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = velocity.x * FRICTION

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		if velocity.y > CUT_OFF_JUMP_VELOCITY:
			velocity.y = JUMP_VELOCITY
			if play_jump_fx:
				jump_sfx.play()
				play_jump_fx = false
				timer.start()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if abs(velocity.x) < MAX_SPEED || not velocity.x / direction > 0:
			#Readd the lost value due to friction when walking
			if is_on_floor():
				velocity.x = velocity.x * (1/(FRICTION))
			#Apply force
			velocity.x += direction * SPEED * delta
			#When walking direction and force direction are not the same, apply extra force for faster direction switching
			if not velocity.x / direction > 0:
				velocity.x += direction * SPEED * CHANGE_DIRECTION_SPEED * delta
			#Reduce speed to MAX_WALK_SPEED when walking
			if abs(velocity.x) > MAX_WALK_SPEED && is_on_floor():
				velocity.x = direction * MAX_WALK_SPEED
	
	move_and_slide()

func reset():
	position = respawn_point
	velocity = Vector2(0,0)



func _on_jump_fx_timer_timeout():
	play_jump_fx = true
