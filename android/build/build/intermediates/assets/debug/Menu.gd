extends Control
@export var level := 1
@onready var button = $MarginContainer/VBoxContainer/Button
@onready var audio_stream_player = $ClickButtonSound
@onready var tab_change_sound = $tabChangeSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():
	tab_change_sound.play()
	get_tree().change_scene_to_file("res://scenes/Level"+str(level)+".tscn")

func _on_left_button_up():
	if level > 1:
		level -= 1
		updateLevelButton()
		audio_stream_player.play()

func _on_right_button_up():
	level += 1
	updateLevelButton()
	audio_stream_player.play()
	
func updateLevelButton():
	button.text = "          "+str(level)

func _on_settings_button_up():
	tab_change_sound.play()
	get_tree().change_scene_to_file("res://scenes/options.tscn")
