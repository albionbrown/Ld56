extends CanvasLayer

@export var player : Player
var last_frame_time = 0
var bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar = get_node('ReloadingLabel/ProgressBar')
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hide()
	if (player.is_reloading()):
		show()
		last_frame_time += delta
		bar.value = 100 - ((last_frame_time / player.reload_time) * 100)
	else:
		last_frame_time = 0
		bar.value = 100
