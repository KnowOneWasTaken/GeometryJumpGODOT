# winscreen
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_button_up():
	#get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().change_tab_to_menu_from_level()
	get_parent().get_parent().close_level()
	queue_free()
