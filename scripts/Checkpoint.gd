extends Node2D
@onready var checkpoint_sfx = $CheckpointSFX


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body.respawn_point != Vector2(position.x, position.y-120):
		checkpoint_sfx.play()
		body.respawn_point = Vector2(position.x, position.y-120)
