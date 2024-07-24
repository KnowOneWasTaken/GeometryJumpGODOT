extends Control
var music = true
var sfx = true
@onready var music_switch = $"Control/CenterContainer/VBoxContainer/music-switch"
@onready var sfx_switch = $"Control/CenterContainer/VBoxContainer/sfx-switch"
const SWITCH_OFF = preload("res://assets/original/switch_off.png")
const SWITCH_ON = preload("res://assets/original/switch_on.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_settings_button_up():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_musicswitch_button_up():
	music = not music
	match music:
		false: 
			music_switch.icon = SWITCH_OFF
		true: 
			music_switch.icon = SWITCH_ON
		_: 
			music_switch.icon = SWITCH_ON
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(index, music)

func _on_sfxswitch_button_up():
	sfx = not sfx
	match sfx:
		false: sfx_switch.icon = SWITCH_OFF
		true: sfx_switch.icon = SWITCH_ON
		_: sfx_switch.icon = SWITCH_ON
	var index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(index, sfx)
