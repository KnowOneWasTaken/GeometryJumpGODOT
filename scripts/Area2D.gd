extends Area2D
@onready var goal_sfx = $GoalSFX
var goal_reached = false
@onready var gpu_particles_2d = $"../GPUParticles2D"
@onready var win_screen := load("res://scenes/win_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	gpu_particles_2d.emitting = true
	if not goal_reached:
		print("Goal reached!")
		goal_sfx.play()
		var screen = win_screen.instantiate()
		add_child(screen)
		body.won = true
	goal_reached = true
	
