extends Control
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	play()

func play():
	if audio_stream_player != null:
		if !audio_stream_player.playing:
			var url_base := "res://assets/sounds/backgroundMusic/"
			var url : String
			match randi_range(0,13):
				0: url = url_base + "8bit_dungeon_boss.mp3"
				1: url = url_base + "A_Night_Of_Dizzy_Spells.mp3"
				2: url = url_base + "chopsticks.mp3"
				3: url = url_base + "digestive_biscuit.mp3"
				4: url = url_base + "dub_hub.mp3"
				5: url = url_base + "itty_bitty_8_bit.mp3"
				6: url = url_base + "MAZE.mp3"
				7: url = url_base + "mountain_trails.mp3"
				8: url = url_base + "Night_Shade.mp3"
				9: url = url_base + "pixelland.mp3"
				10: url = url_base + "Powerup.mp3"
				11: url = url_base + "Sour Rock.mp3"
				12: url = url_base + "Underclocked.mp3"
				13: url = url_base + "virtual_boy.mp3"
				_: url = url_base + "8bit_dungeon_boss.mp3"
			play_url(url)

func play_url(track_url : String):
	stop()
	var new_track = load(track_url)
	audio_stream_player.stream = new_track
	audio_stream_player.play()

func stop():
	audio_stream_player.stop()
