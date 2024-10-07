extends CanvasLayer

@export var player : Player
var bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar = get_node('GasBar')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player != null):
		var amount : float
		amount = player.backpack.total as float / player.backpack.max_total as float
		bar.value = amount * 100.0
