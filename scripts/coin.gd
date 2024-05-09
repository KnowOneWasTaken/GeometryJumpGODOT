extends Node2D
var timer = 0

func _on_area_2d_body_entered(_body):
	queue_free()

func _process(delta):
	var t = Transform2D()
	timer += 0.05 * delta
	t.y += cos(timer)*40
	transform = t # Change the node's transform to what we calculated.
