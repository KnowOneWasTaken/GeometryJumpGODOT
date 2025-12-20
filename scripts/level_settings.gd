extends Control
var ghost_button_on = true
var gold_button_on = true
@onready var ghost_button: TouchScreenButton = $ghost_button
@onready var gold_button: TouchScreenButton = $gold_button
const SWITCH_ON = preload("res://assets/original/Buttons/switch_on.png")
const SWITCH_OFF = preload("res://assets/original/Buttons/switch_off.png")
@onready var level = get_parent().get_parent().get_parent()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $AudioStreamPlayer/Timer
@onready var creative_button: Button = $CreativeButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_preferences()
	if get_parent().get_parent().isEditMode:
		creative_button.icon = load("res://assets/original/Buttons/BEditModeOn.png")
	else:
		creative_button.icon = load("res://assets/original/Buttons/BEditModeOff.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	timer.start()
	visible = false
	audio_stream_player.play()
	save_preferences()


func _on_button_2_button_up() -> void:
	save_preferences()
	get_parent().get_parent().get_parent().get_parent().reset_level()


func _on_ghost_button_released() -> void:
	audio_stream_player.play()
	ghost_button_on = !ghost_button_on
	level.set_ghost_visibility(ghost_button_on)
	update_ghost_button()


func _on_gold_button_released() -> void:
	audio_stream_player.play()
	gold_button_on = !gold_button_on
	level.set_gold_ghost_visibility(gold_button_on)
	update_gold_button()

func update_ghost_button():
	if ghost_button_on:
		ghost_button.texture_normal = SWITCH_ON
	else:
		ghost_button.texture_normal = SWITCH_OFF
		
func update_gold_button():
	if gold_button_on:
		gold_button.texture_normal = SWITCH_ON
	else:
		gold_button.texture_normal = SWITCH_OFF

func load_preferences():
	var file = FileAccess.open("user://ghost_visibility.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			var data_received = json.data
			ghost_button_on = bool(data_received[0].get("visibility"))
			gold_button_on = bool(data_received[1].get("visibility"))
			file.close()
		else:
			print("Error  while parsing ghost_visibility.json")
	else:
		print("No preferences for ghost visibility found")
	update_ghost_button()
	update_gold_button()
	level.set_ghost_visibility(ghost_button_on)
	level.set_gold_ghost_visibility(gold_button_on)

func save_preferences():
	var preferences = []
	preferences.append({"visibility": ghost_button_on})
	preferences.append({"visibility": gold_button_on})
	var file = FileAccess.open("user://ghost_visibility.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(preferences))
		file.close()
	else:
		print("Failed to open file for writing")


func _on_timer_timeout() -> void:
	get_parent().get_parent().remove_settings_overlay()

func _on_creative_button_button_up() -> void:
	get_parent().get_parent().isEditMode = !get_parent().get_parent().isEditMode;
	if get_parent().get_parent().isEditMode:
		creative_button.icon = load("res://assets/original/Buttons/BEditModeOn.png")
	else:
		creative_button.icon = load("res://assets/original/Buttons/BEditModeOff.png")
