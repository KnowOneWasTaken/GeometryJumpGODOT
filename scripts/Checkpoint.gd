extends Node2D
@onready var checkpoint_sfx = $CheckpointSFX
@onready var gpu_particles_2d = $GPUParticles2D
@onready var timer = $GPUParticles2D/Timer


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
		gpu_particles_2d.emitting = true
		timer.start()

func _on_timer_timeout():
	gpu_particles_2d.emitting = false
