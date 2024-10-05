@tool

class_name HealthBar extends Node2D

var color_rect : ColorRect
@export var attached_to_node : Node2D
@export var health : int
@export var max_health : int

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect = get_node('ColorRect')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
func _draw():
	var l = position
	draw_rect(
		Rect2(global_position.x, global_position.y, 100.0, 10.0),
		Color(0.0, 255.0, 0.0)
	)
