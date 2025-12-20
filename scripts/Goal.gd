# Goal -> Goal
extends Area2D
@onready var goal_sfx = $GoalSFX
var goal_reached = false
@onready var gpu_particles_2d = $"../GPUParticles2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.isEditMode:
		return
	if not goal_reached:
		var best_time = body.win()
		print("Goal reached!")
		goal_sfx.play()
		body.get_parent().get_node("UI").win(best_time, body.isRunValid)
		#var screen = win_screen.instantiate()
		#add_child(screen)
	gpu_particles_2d.emitting = true
	goal_reached = true
	
