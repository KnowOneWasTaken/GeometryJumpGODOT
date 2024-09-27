extends Node2D
@onready var checkpoint_sfx = $CheckpointSFX
var particlePlayer := load("res://scenes/particle_player.tscn")


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
		body.is_respawn_point_default = false
		var newParticle = particlePlayer.instantiate()
		add_child(newParticle)
		newParticle.set_image(preload("res://assets/original/particleCheckpoint.png"))
