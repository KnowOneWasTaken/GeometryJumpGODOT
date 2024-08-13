extends CharacterBody2D

const SPEED = 80.0 * 45 * 1.4
const JUMP_VELOCITY = -1900.0
const MAX_SPEED = 900
const FRICTION = 0.6
const CHANGE_DIRECTION_SPEED = 2.0
const MAX_WALK_SPEED = 700
const CUT_OFF_JUMP_VELOCITY = -1000
const WALL_FRICTION = 0.93  # New constant for wall friction
@onready var animated_sprite_2d = $AnimatedSprite2D
var particlePlayer := load("res://scenes/particle_player.tscn")
var won = false
@onready var timer = $JumpFXTimer
var play_jump_fx := true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 6
@onready var jump_sfx = $JumpSFX
@export var default_respawn_point := Vector2(-300, 60)
var respawn_point := default_respawn_point
var died := false

func _physics_process(delta):
	if not died:
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
			if abs(velocity.x) < MAX_SPEED or not velocity.x / direction > 0:
				# Readd the lost value due to friction when walking
				if is_on_floor():
					velocity.x = velocity.x * (1 / (FRICTION))
				# Apply force
				velocity.x += direction * SPEED * delta
				# When walking direction and force direction are not the same, apply extra force for faster direction switching
				if not velocity.x / direction > 0:
					velocity.x += direction * SPEED * CHANGE_DIRECTION_SPEED * delta
				# Reduce speed to MAX_WALK_SPEED when walking
				if abs(velocity.x) > MAX_WALK_SPEED and is_on_floor():
					velocity.x = direction * MAX_WALK_SPEED

		# Apply wall friction if the player is pressing against a wall
		if is_on_wall() && direction != 0:
			velocity.y *= WALL_FRICTION
		
		if not won:
			move_and_slide()

func reset():
	position = respawn_point
	velocity = Vector2(0, 0)
	died = false
	animated_sprite_2d.visible = true

func _on_jump_fx_timer_timeout():
	play_jump_fx = true
	
func die():
	died = true
	velocity.x = 0
	velocity.y = 0
	animated_sprite_2d.visible = false
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/particlePlayer.png"))
	
func win():
	velocity = Vector2(0, 0)
	won = true
