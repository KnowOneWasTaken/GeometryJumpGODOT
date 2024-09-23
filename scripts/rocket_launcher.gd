extends Node2D
@export var direction := Vector2(1,0)
@export var speed := 480.0
@export var offset := 0.01
@export var reload := 2.0
@onready var timer = $Timer
var rocket := load("res://scenes/LevelObjects/rocket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = offset
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var newRocket = rocket.instantiate()
	add_child(newRocket)
	newRocket.direction = direction
	newRocket.speed = speed
	newRocket.rotate_rocket(direction)
	timer.wait_time = reload
	timer.start()
