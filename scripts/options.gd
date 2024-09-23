# options
extends Control
@onready var music_slider = $"VBoxContainer2/Music"
@onready var sfx_slider = $"VBoxContainer2/SFX"
@onready var tab_change_sound = $tabChangeSound
var music_volume = 1
var sfx_volume = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	music_slider.value = music_volume
	sfx_slider.value = sfx_volume
	var index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, -50+music_volume/2.0)
	index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, -50+sfx_volume/2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_settings_button_up():
	tab_change_sound.play()
	get_parent().change_tab_to_menu_from_options()

func _on_music_slider_value_changed(_value):
	music_volume = music_slider.value
	update_bus("Music")


func _on_sfx_slider_value_changed(_value):
	sfx_volume = sfx_slider.value
	update_bus("SFX")
	
func update_bus(bus : String):
	var index = AudioServer.get_bus_index(bus)
	var value
	match bus:
		"Music": value = music_volume
		"SFX": value = sfx_volume
	AudioServer.set_bus_volume_db(index, -50+value/2)
	AudioServer.set_bus_mute(index, value < 1)
