extends Area2D

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _on_body_entered(body):
	timer.start()
	Engine.time_scale = 0.15
	audio_stream_player_2d.play()
	body.visible = false

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
