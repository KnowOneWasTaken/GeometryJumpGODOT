extends Area2D

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@export var slowMotionTime = 0.15
var player

#Gets called when player enters Kill Zone -> player killed
func _on_body_entered(body):
	#Slows down time and starts a timer that will trigger a reset
	timer.start()
	Engine.time_scale = slowMotionTime
	audio_stream_player_2d.play()
	body.visible = false
	player = body

#gets called when timer runs out
func _on_timer_timeout():
	#resets the level
	#get_tree().reload_current_scene()
	player.reset()
	player.visible = true
	Engine.time_scale = 1
