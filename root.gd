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
var levelAmount = 21
var newLevel
var coins_collected = 0
@onready var tab_change_sound: AudioStreamPlayer = $tabChangeSound

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	newMenu = menu.instantiate()
	add_child(newMenu)
	newMenu.set_coins(coins_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass

func save_data():
	var data = []
	data.append({"coins_collected": coins_collected})
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
	else:
		print("Failed to open file for writing")

func load_data():
	var file = FileAccess.open("user://data.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			var data_received = json.data
			coins_collected = int(data_received[0].get("coins_collected"))
			file.close()
		else:
			print("Error  while parsing data.json")
	else:
		print("No data found")

func add_coins(amount):
	coins_collected += amount
	save_data()

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
	newMenu.set_coins(coins_collected)

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
	if lvl <= levelAmount:
		levelScene = load("res://scenes/Levels/new/L"+str(lvl)+".tscn")
		newLevel = levelScene.instantiate()
		add_child(newLevel)
		newLevel.set_level(level)
	else:
		print("Cannot open level because this level is greater than the levelAmount set in root")
		open_tab_menu()
	
func close_tab_level():
	newLevel.queue_free()
	
func reset_level():
	change_tab_to_menu_from_level()
	change_tab_to_level(level)
