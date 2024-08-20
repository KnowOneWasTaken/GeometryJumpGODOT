extends Node2D
@export var boost = 10000
@export var direction = Vector2(0,-1)
var inArea = false
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inArea and not player.is_on_floor():
		player.velocity += direction * boost * delta

func _on_area_2d_body_entered(body):
	inArea = true
	player = body

func _on_area_2d_body_exited(_body):
	inArea = false
