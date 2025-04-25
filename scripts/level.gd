#level.gd

extends Node2D
@onready var ghost: Node2D = $Ghost
@onready var ghost_gold: Node2D = $"ghost-gold"
@onready var ui: CanvasLayer = $UI
const PLAYER = preload("res://scenes/LevelObjects/Player.tscn")
var peer = ENetMultiplayerPeer.new()
var level
@onready var original_player: CharacterBody2D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.load_preferences()

func set_level(lvl):
	level = lvl

func add_coins_to_total(amount):
	get_parent().add_coins(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
