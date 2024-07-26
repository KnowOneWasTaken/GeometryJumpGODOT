extends Area2D
@onready var goal_sfx = $GoalSFX
@onready var timer = $Timer
var goal_reached = false
@onready var gpu_particles_2d = $"../GPUParticles2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	gpu_particles_2d.emitting = true
	if not goal_reached:
		print("Goal reached!")
		goal_sfx.play()
		timer.start()
	goal_reached = true


func _on_timer_timeout():
	gpu_particles_2d.emitting = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
