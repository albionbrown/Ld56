extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_emit_spawn(scene, emitter) -> void:
	var new_object = scene.instantiate()
	new_object.position = emitter.position
	new_object.emitter = emitter
	new_object.set_name(generate_word(5))
	add_child(new_object)

func generate_word(length):
	var characters = 'abcdefghijklmnopqrstuvwxyz'
	var word: String
	var n_char = len(characters)
	for i in range(length):
		word += characters[randi()% n_char]
	return word


func _on_emitter_2_spawn() -> void:
	pass # Replace with function body.
