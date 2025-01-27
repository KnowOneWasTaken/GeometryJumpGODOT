# root
extends Control
var menu := load("res://scenes/Tabs/menu.tscn")
var newMenu
var options := load("res://scenes/Tabs/options.tscn")
var newOptions
var music_volume = 70
var sfx_volume = 100
var levelScene
var level := 1
var levelAmount = 20
var newLevel
@onready var tab_change_sound: AudioStreamPlayer = $tabChangeSound

# Called when the node enters the scene tree for the first time.
func _ready():
	newMenu = menu.instantiate()
	add_child(newMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass

func change_tab_to_options():
	level = newMenu.level
	close_tab_menu()
	open_tab_options()
	tab_change_sound.play()

func change_tab_to_menu_from_options():
	close_tab_options()
	open_tab_menu()
	tab_change_sound.play()
	newMenu.setLevel(level)
	
func change_tab_to_level(lvl):
	level = lvl
	close_tab_menu()
	open_tab_level(lvl)
	tab_change_sound.play()

func change_tab_to_menu_from_level():
	close_tab_level()
	open_tab_menu()
	tab_change_sound.play()
	newMenu.setLevel(level)
	
func open_tab_menu():
	newMenu = menu.instantiate()
	add_child(newMenu)

func close_tab_menu():
	newMenu.queue_free()

func open_tab_options():
	newOptions = options.instantiate()
	add_child(newOptions)
	newOptions.music_slider.value = music_volume
	newOptions.sfx_slider.value = sfx_volume

func close_tab_options():
	music_volume = newOptions.music_slider.value
	sfx_volume = newOptions.sfx_slider.value
	newOptions.queue_free()

func open_tab_level(lvl):
	levelScene = load("res://scenes/Levels/new/L"+str(lvl)+".tscn")
	newLevel = levelScene.instantiate()
	add_child(newLevel)

func close_tab_level():
	newLevel.queue_free()
