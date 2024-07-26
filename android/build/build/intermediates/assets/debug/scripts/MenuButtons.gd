extends Control
@onready var tab_change_sound = $tabChangeSound
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_button_up():
	tab_change_sound.play()
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
