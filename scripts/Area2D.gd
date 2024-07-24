extends Area2D
@onready var label = $Label
@onready var goal_sfx = $GoalSFX
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	print("Goal reached!")
	label.text = "Goal reached!"
	goal_sfx.play()
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
