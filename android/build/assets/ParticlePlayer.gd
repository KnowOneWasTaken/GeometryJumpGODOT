extends GPUParticles2D
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play():
	emitting = true
	timer.start()

func stop():
	emitting = false


func _on_timer_timeout():
	stop()
	queue_free()

func set_image(image):
	texture = image
