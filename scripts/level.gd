#level.gd
extends Node2D
@onready var ui: CanvasLayer = $UI
@onready var ghost: Node2D = $Ghost
@onready var ghost_gold: Node2D = $"ghost-gold"
const PLAYER = preload("res://scenes/LevelObjects/Player.tscn")
var peer = ENetMultiplayerPeer.new()
var level
@onready var original_player: CharacterBody2D = $Player
@onready var blocks: Node = $Map/Blocks


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.load_preferences()

func set_level(lvl):
	level = lvl

func add_coins_to_total(amount):
	get_parent().add_coins(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_ghost_visibility(boolean):
	ghost.visible = boolean

func set_gold_ghost_visibility(boolean):
	ghost_gold.visible = boolean

func get_gold_ghost_visibility() -> bool:
	return ghost_gold.visible

func get_ghost_visibility() -> bool:
	return ghost.visible
	
func add_player(pid):
	var player = PLAYER.instantiate()
	player.name = str(pid)
	player.position = Vector2(-300, 60)
	add_child(player)

func _unhandled_input(event):
	print("Event detected")
	print(event is InputEventScreenTouch)
	print(event is InputEventMouseButton)
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		print("-------------")
		print("new event")
		print("event is screentouch or mouse event")
		if ui.isEditMode:
			var world_pos = get_global_mouse_position()
			print(world_pos.x)
			print(world_pos.y)
			spawn_block(world_pos)

func spawn_block(world_pos):
	var block
	if ui.selectedBlock != null:
		block = ui.selectedBlock.instantiate()
	var x = floor((world_pos.x)/120) * 120 + 60
	var y = floor((world_pos.y)/120) * 120 + 60
	for block_c in blocks.get_children():
		if block_c.position.x == x and block_c.position.y == y:
			block_c.free()
	if ui.selectedBlock != null:
		blocks.add_child(block)
		print("Add block: ", x, ", ",y)
		block.position = Vector2(x,y)
