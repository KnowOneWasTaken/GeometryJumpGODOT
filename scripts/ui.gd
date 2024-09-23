extends CanvasLayer
# UI
@onready var win_screen := load("res://scenes/UserInterface/win_screen.tscn")
@onready var center_container: CenterContainer = $CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_button_up():
	close_level()
	
func win():
	var screen = win_screen.instantiate()
	center_container.add_child(screen)

func close_level():
	get_parent().get_parent().change_tab_to_menu_from_level()
