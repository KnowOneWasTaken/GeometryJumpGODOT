# menu
extends Control
var levelAmount
@export var level := 1
@onready var button = $MarginContainer/VBoxContainer/Button
@onready var audio_stream_player = $ClickButtonSound
@onready var level_button = $MarginContainer/VBoxContainer/Button
@onready var coins_label: Label = $coins_label

# Called when the node enters the scene tree for the first time.
func _ready():
	levelAmount = get_parent().levelAmount
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_coins(amount):
	coins_label.text = str(amount)

func _on_button_button_up():
	get_parent().change_tab_to_level(level)

func _on_left_button_up():
	if level > 1:
		level -= 1
		updateLevelButton()
		audio_stream_player.play()
		update_font_size()

func _on_right_button_up():
	if level < levelAmount:
		level += 1
	updateLevelButton()
	audio_stream_player.play()

func updateLevelButton():
	button.text = "Level "+str(level)
	update_font_size()

func setLevel(lvl):
	level = lvl
	if lvl > levelAmount:
		level = levelAmount
	updateLevelButton()

func update_font_size():
	if level < 10:
		level_button.add_theme_font_size_override("font_size", 160)
	elif level < 100:
		level_button.add_theme_font_size_override("font_size", 150)
	else:
		level_button.add_theme_font_size_override("font_size", 135)


func _on_touch_screen_button_released() -> void:
	get_parent().change_tab_to_options()
