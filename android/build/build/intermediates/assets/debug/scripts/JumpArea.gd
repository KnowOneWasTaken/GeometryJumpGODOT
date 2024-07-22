extends Area2D
var isInArea := false
var player = null
@onready var timer = $Timer
@onready var slime_sfx = $"../SlimeSFX"
@export var SLIME_VELOCITY = -5400
@export var CUT_OFF_VELOCITY = -1600

func _on_body_entered(body):
	isInArea = true
	player = body
	if player.velocity.y > CUT_OFF_VELOCITY:
		player.velocity.y += SLIME_VELOCITY
		slime_sfx.play()
	timer.start()


func _on_body_exited(_body):
	isInArea = false



func _on_timer_timeout():
	if isInArea:
		if player.velocity.y > CUT_OFF_VELOCITY:
			player.velocity.y += SLIME_VELOCITY
		timer.start()
