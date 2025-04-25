extends Node2D
var direction = Vector2(1,0)
var speed = 120 * 4
@onready var timer = $Timer
var particlePlayer := load("res://scenes/particle_player.tscn")
@onready var timer_2 = $Timer2
@onready var sprite_2d = $Sprite2D
var exploded := false
@onready var kill_zone = $KillZone
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	#TODO rotation of rocket

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + direction * speed * delta
	if sprite_2d.visible:
		#TODO particles
		pass


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if not body.died and not body.won:
		player = body
		player.die()
	explode()


func _on_timer_2_timeout():
	queue_free()


func _on_area_world_body_entered(_body):
	explode()

func explode():
	if not exploded:
		audio_stream_player_2d.play()
		var newParticle = particlePlayer.instantiate()
		add_child(newParticle)
		newParticle.set_image(preload("res://assets/original/particleBullet.png"))
		sprite_2d.visible = false
		exploded = true
		timer_2.start()
		kill_zone.queue_free()
		speed = 120

func rotate_rocket(direc):
		rotate(atan(direc.y/direc.x))
