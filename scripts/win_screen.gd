# winscreen
extends Node2D
@onready var label: Label = $Container/Label
@onready var time: Label = $Container/time
@onready var time2: Label = $Container/time2
@onready var coins: Label = $Container/coins
@onready var button: Button = $Button
@onready var coins_text: Label = $Container/coins_text


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Level " + str(get_parent().get_parent().get_parent().level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if coins.text == "1":
		coins_text.text = "coin!"
	else:
		coins_text.text = "coins!"

func _on_button_button_up():
	print("Exit level through win screen")
	#get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().change_tab_to_menu_from_level()
	get_parent().get_parent().exit_level(true)

func _on_button_2_button_up() -> void:
	get_parent().get_parent().get_parent().get_parent().reset_level()
