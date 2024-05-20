extends Node2D
var timer = 0
@onready var animation_player = $AnimationPlayer

func _on_area_2d_body_entered(_body):
	animation_player.play("CollectCoin")

#func _process(delta):

