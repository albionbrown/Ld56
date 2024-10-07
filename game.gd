extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_emit_spawn(scene) -> void:
	var new_object = scene.instantiate()
	new_object.position = position
	add_child(new_object)
