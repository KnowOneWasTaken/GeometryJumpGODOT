extends CanvasLayer
# UI
@onready var win_screen := load("res://scenes/UserInterface/win_screen.tscn")
@onready var center_container: CenterContainer = $CenterContainer
@onready var label: Label = $Label
@onready var player: CharacterBody2D = $"../Player"
var days
var hours
var minutes
var seconds
var ms
var player_time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_timer()


func _on_exit_button_up():
	close_level()
	
func win():
	var screen = win_screen.instantiate()
	center_container.add_child(screen)
	update_timer()
	screen.time.text = label.text + str(player_time % 10)
	screen.coins.text = str(player.collected_coins)
	

func close_level():
	get_parent().get_parent().change_tab_to_menu_from_level()

func update_timer():
	player_time = player.time_since_death
	label.text = time_to_string(player_time)

func int_to_time(integer):
	if integer < 10:
		return "0"+str(integer)
	else:
		return str(integer)

func time_to_string(time):
	days = floor(time/(1000*60*60*24))
	hours = floor(time/(1000*60*60)) % 24
	minutes = floor(time/(1000*60)) % 60
	seconds = floor(time/(1000)) % 60
	ms = floor((floor(time) % 1000) / 10)
	#ms = floor(time) % 1000
	
	if days > 0:
		return str(days)+":"+int_to_time(hours)+":"+int_to_time(minutes)+":"+int_to_time(seconds)+":"+int_to_time(ms)
	else:
		if hours > 0:
			return int_to_time(hours)+":"+int_to_time(minutes)+":"+int_to_time(seconds)+":"+int_to_time(ms)
		else:
			if minutes > 0:
				return int_to_time(minutes)+":"+int_to_time(seconds)+":"+int_to_time(ms)
			else:
				return int_to_time(seconds)+":"+int_to_time(ms)
