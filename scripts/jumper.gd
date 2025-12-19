# Jumper
extends Node2D
var isInArea := false
var isInAreaL := false
var isInAreaR := false
var isInAreaB := false
var player = null
@onready var timer = $JumpArea/Timer
@onready var slime_sfx = $SlimeSFX
@onready var timerL = $JumpAreaLEFT/TimerLEFT
@onready var timerR = $JumpAreaRIGHT/TimerRIGHT
@onready var timerB = $JumpAreaBOTTOM/TimerBOTTOM
@export var SLIME_VELOCITY = -5400
@export var CUT_OFF_VELOCITY = -1600
var particlePlayer := load("res://scenes/particle_player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jump_area_body_entered(body: Node2D) -> void:
	isInArea = true
	player = body
	player.velocity.y += SLIME_VELOCITY
	slime_sfx.play()
	timer.start()
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/particleSlime.png"))


func _on_jump_area_body_exited(_body: Node2D) -> void:
	isInArea = false


func _on_timer_timeout() -> void:
	if isInArea:
		player.velocity.y += SLIME_VELOCITY
		timer.start()


func _on_jump_area_bottom_body_entered(body: Node2D) -> void:
	isInAreaB = true
	player = body
	player.velocity.y -= SLIME_VELOCITY
	slime_sfx.play()
	timerB.start()
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/particleSlime.png"))


func _on_jump_area_bottom_body_exited(body: Node2D) -> void:
	isInAreaB = false


func _on_jump_area_right_body_entered(body: Node2D) -> void:
	isInAreaR = true
	player = body
	player.velocity.x -= SLIME_VELOCITY
	slime_sfx.play()
	timerR.start()
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/particleSlime.png"))


func _on_jump_area_right_body_exited(body: Node2D) -> void:
	isInAreaR = false


func _on_timer_right_timeout() -> void:
	if isInAreaR:
		player.velocity.x -= SLIME_VELOCITY
		timerR.start()


func _on_timer_bottom_timeout() -> void:
	if isInAreaB:
		player.velocity.y -= SLIME_VELOCITY
		timerB.start()


func _on_jump_area_left_body_entered(body: Node2D) -> void:
	isInAreaL = true
	player = body
	player.velocity.x += SLIME_VELOCITY
	slime_sfx.play()
	timerL.start()
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/particleSlime.png"))


func _on_timer_left_timeout() -> void:
	if isInAreaL:
		player.velocity.x += SLIME_VELOCITY
		timerL.start()


func _on_jump_area_left_body_exited(body: Node2D) -> void:
	isInAreaL = false
