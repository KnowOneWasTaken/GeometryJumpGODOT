extends Node2D
var timer = 0
@onready var animation_player = $AnimationPlayer
var time = 0
var y = 0

func _ready():
	y = position.y

func _on_area_2d_body_entered(_body):
	animation_player.play("CollectCoin")

#func _process(delta):

func _process(delta):
	time += delta
	position.y = y + sin(time*4)*5
