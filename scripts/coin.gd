#coin
extends Node2D
var timer = 0
@onready var animation_player = $AnimationPlayer
var time = 0
var y = 0
var particlePlayer := load("res://scenes/particle_player.tscn")

func _ready():
	y = position.y

func _on_area_2d_body_entered(body):
	animation_player.play("CollectCoin")
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/Particles/particleStar-new.png"))
	body.coin_collected()

func _process(delta):
	time += delta
	position.y = y + sin(time*4)*5

func respawn():
	animation_player.play("RESET")
