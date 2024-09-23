# KillZone
extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var player

#Gets called when player enters Kill Zone -> player killed
func _on_body_entered(body):
	if not body.died and not body.won:
		audio_stream_player_2d.play()
		player = body
		player.die()
