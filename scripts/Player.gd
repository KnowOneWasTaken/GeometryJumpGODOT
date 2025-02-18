extends CharacterBody2D
# Player
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
@onready var timer_die = $Timer
var time_since_death = 0.0
var time_when_started = Time.get_ticks_msec()
var collected_coins = 0
var is_respawn_point_default = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 6
@onready var jump_sfx = $JumpSFX
var default_respawn_point
var respawn_point
var died := false

var player_movements = []  # Liste, um die Bewegungen des Spielers zu speichern
var best_run = []
var ghost_index = 0
var ghost
var level
var started

func _ready():
	default_respawn_point = position
	respawn_point = default_respawn_point
	ghost =  $"../Ghost"
	level = str(get_parent().get_parent().level)
	load_best_run()
	started = false
	
func parse_vector2(pos_string: String) -> Vector2:
	pos_string = pos_string.lstrip("(").rstrip(")")  # Klammern entfernen
	var parts = pos_string.split(", ")  # In X und Y aufteilen
	if parts.size() == 2:
		return Vector2(float(parts[0]), float(parts[1]))  # In Vector2 umwandeln
	return Vector2.ZERO  # Falls Fehler, Rückgabe als (0, 0)
	
func _physics_process(delta):
	if ghost_index < best_run.size():
		var image = $"../Ghost/image"
		var ghost_data = best_run[ghost_index]
		while(ghost_data["time"] < time_since_death):
			if ghost_index < best_run.size() - 1:
				ghost_index += 1
				ghost_data = best_run[ghost_index]
			else:
				break
		print(time_since_death)
		print(ghost_data["time"])
		print("-")
		print(ghost_index)
		print(best_run.size())
		print("##")
		image.visible = true
		var node_position = Vector2(ghost_data["position_x"], ghost_data["position_y"])
		ghost.global_position = node_position  # Setzt die Position des Nodes
		#ghost.rotation = ghost_data.get("rotation", 0) # Optional
		if ghost_index >= best_run.size()-1:
			image.visible = true
	else:
		var image = $"../Ghost/image"
		image.visible = false

	if not died:
		if not won:
			if started:
				time_since_death = Time.get_ticks_msec() - time_when_started
			else:
				time_when_started = Time.get_ticks_msec()
				time_since_death = 0
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			velocity.x = velocity.x * FRICTION

		# Handle jump.
		if Input.is_action_pressed("jump") and is_on_floor():
			started = true
			if velocity.y > CUT_OFF_JUMP_VELOCITY:
				velocity.y = JUMP_VELOCITY
				if play_jump_fx:
					jump_sfx.play()
					play_jump_fx = false
					timer.start()

		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			started = true
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
	record_player_move()
	
func load_best_run():
	var file = FileAccess.open("user://best_run"+level+".json", FileAccess.READ)
	if file:
		var json_data = JSON.parse_string(file.get_as_text())
		if json_data:
			best_run = json_data
			print("Loaded best run")
		file.close()

func record_player_move():
	# Speichern der aktuellen Position des Spielers
	player_movements.append({
		"position_x": global_position.x,
		"position_y": global_position.y,
		"rotation": global_rotation, # if needed
		"time": time_since_death, # Optional: store timestamps for better synchronization
		"visible": $AnimatedSprite2D.visible
	})

func save_run(time):
	var file = FileAccess.open("user://best_run"+level+".json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(player_movements))
		file.close()
	else:
		print("Failed to open file for writing")
	save_time(time)

func save_time(bestTime):
	var time = FileAccess.open("user://best_time"+level+".json", FileAccess.WRITE)
	if time:
		time.store_string(JSON.stringify(JSON.stringify({"time": bestTime})))
		time.close()
	else:
		print("Failed to open file for writing")


func _on_jump_fx_timer_timeout():
	play_jump_fx = true
	
func die():
	died = true
	velocity.x = 0
	velocity.y = 0
	animated_sprite_2d.visible = false
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/playerParticle2.jpg"))
	newParticle.scale.x = 0.01
	newParticle.scale.y = 0.01
	timer_die.start()
	
func win():
	var file = FileAccess.open("user://best_time"+level+".json", FileAccess.READ)
	var best_time = 999999999999
	if file:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			var data_received = json.data
			best_time = int(data_received)
			file.close()
	else:
		print("Failed to open file for writing")
	if best_time > time_since_death:
		save_run(time_since_death)
		print("Saved run")
	velocity = Vector2(0, 0)
	won = true

func _on_timer_timeout():
	if default_respawn_point == respawn_point:
		time_when_started = Time.get_ticks_msec()
		time_since_death = 0
		player_movements.clear()
		ghost_index = 0
		started = false
	position = respawn_point
	velocity = Vector2(0, 0)
	died = false
	animated_sprite_2d.visible = true

func coin_collected():
	collected_coins += 1
