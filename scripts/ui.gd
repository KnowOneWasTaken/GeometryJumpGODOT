extends CanvasLayer
# UI
@onready var win_screen := load("res://scenes/UserInterface/win_screen.tscn")
@onready var center_container: CenterContainer = $CenterContainer
@onready var label: Label = $Label
@onready var player: CharacterBody2D = $"../Player"
@onready var settings := load("res://scenes/UserInterface/level_settings.tscn")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var settings_button: Button = $MarginContainer/MenuButtons/Settings
var days
var hours
var minutes
var seconds
var ms
var player_time
var settings_overlay
var is_settings_open

# Called when the node enters the scene tree for the first time.
func _ready():
	is_settings_open = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_timer()
	pass

func load_preferences():
	settings_overlay  = settings.instantiate()
	center_container.add_child(settings_overlay)
	settings_overlay.load_preferences()
	settings_overlay.queue_free()

func _on_exit_button_up():
	exit_level(false)
	
func win(best_time):
	settings_button.visible = false
	if settings_overlay != null:
		settings_overlay.queue_free()
	var screen = win_screen.instantiate()
	center_container.add_child(screen)
	update_timer()
	screen.time.text = label.text + str(player_time % 10)
	var sign = ""
	if best_time > 0:
		sign = "+"
	elif best_time < 0:
		sign = "-"
	else:
		sign = ""
	screen.time2.text = sign + time_to_string(abs(best_time)) + str(abs(best_time) % 10)
	if best_time < 0:
		screen.get_node("Container/time").modulate = Color(0, 1, 0)
		screen.get_node("Container/time2").modulate = Color(0, 1, 0)
	else:
		if best_time == 0:
			screen.get_node("Container/time").modulate = Color(1, 1, 1)
			screen.get_node("Container/time2").modulate = Color(0, 0, 1)
		else:
			screen.get_node("Container/time").modulate = Color(1, 0, 0)
			screen.get_node("Container/time2").modulate = Color(1, 0, 0)
	screen.coins.text = str(player.collected_coins)
	get_parent().add_coins_to_total(player.collected_coins)

func exit_level(next):
	get_parent().get_parent().change_tab_to_menu_from_level()
	if next:
		get_parent().get_parent().change_tab_to_level(get_parent().level + 1)

func update_timer():
	player_time = player.time_since_death
	player_time = 0
	label.text = time_to_string(player_time)

func int_to_time(integer):
	if integer < 10:
		return "0"+str(integer)
	else:
		return str(integer)

func time_to_string(time):
	days = floor(time/(1000*60*60*24))
	hours = (int)(floor(time/(1000*60*60))) % 24
	minutes = (int)(floor(time/(1000*60))) % 60
	seconds = (int)(floor(time/(1000))) % 60
	ms = floor(((int)(floor(time)) % 1000) / 10)
	#ms = floor(time) % 1000d
	
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


func _on_settings_button_up() -> void:
	audio_stream_player.play()
	if !is_settings_open:
		is_settings_open = true
		settings_overlay  = settings.instantiate()
		center_container.add_child(settings_overlay)
	else:
		remove_settings_overlay
		
func remove_settings_overlay():
		is_settings_open = false
		settings_overlay.queue_free()
