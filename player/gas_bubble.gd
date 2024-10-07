class_name GasBubble extends RigidBody2D

var damage
var duration
var last_delta_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(0.1, 0.1)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	last_delta_time += delta
	var duration_scale_ratio = (last_delta_time / duration)
	damage = 5 - (duration_scale_ratio * 5)
	scale = Vector2(duration_scale_ratio, duration_scale_ratio)
	
	if (last_delta_time >= duration):
		queue_free()
	pass
