extends Node2D
var isInArea := false
var player = null
@onready var timer = $JumpArea/Timer
@onready var slime_sfx = $SlimeSFX
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
	if player.velocity.y > CUT_OFF_VELOCITY:
		jump()


func _on_jump_area_body_exited(_body: Node2D) -> void:
	isInArea = false


func _on_timer_timeout() -> void:
	if isInArea:
		jump()

func jump() -> void:
	player.velocity.y += SLIME_VELOCITY
	slime_sfx.play()
	timer.start()
	var newParticle = particlePlayer.instantiate()
	add_child(newParticle)
	newParticle.set_image(preload("res://assets/original/Particles/particleSlime.png"))
