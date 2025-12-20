extends Node2D
@onready var sprite_2d: Sprite2D = $image

func _ready():
	sprite_2d.modulate = Color.YELLOW
