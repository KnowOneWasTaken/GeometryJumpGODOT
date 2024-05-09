extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	timer.start()
	Engine.time_scale = 0.15

func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
