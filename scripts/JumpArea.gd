extends Area2D
var isInArea = false
var player = null
@onready var timer = $Timer
@onready var slime_sfx = $"../SlimeSFX"

func _on_body_entered(body):
	isInArea = true
	player = body
	if body.velocity.y > - 4500:
		body.velocity.y -= 5300
		slime_sfx.play()
	timer.start()


func _on_body_exited(_body):
	isInArea = false



func _on_timer_timeout():
	if isInArea:
		if player.velocity.y > - 4500:
			player.velocity.y -= 5300
		timer.start()
