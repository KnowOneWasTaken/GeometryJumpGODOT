extends Control
@onready var music_slider = $"VBoxContainer2/Music-Slider"
@onready var sfx_slider = $"VBoxContainer2/SFX-Slider"
@onready var tab_change_sound = $tabChangeSound

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, -50+music_slider.value/2)
	index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, -50+sfx_slider.value/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_settings_button_up():
	tab_change_sound.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_music_slider_value_changed(_value):
	update_bus("Music")


func _on_sfx_slider_value_changed(_value):
	update_bus("SFX")
	
func update_bus(bus : String):
	var index = AudioServer.get_bus_index(bus)
	var value
	match bus:
		"Music": value = music_slider.value
		"SFX": value = sfx_slider.value
	AudioServer.set_bus_volume_db(index, -50+value/2)
	AudioServer.set_bus_mute(index, value < 1)
