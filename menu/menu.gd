class_name Menu extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_key_pressed(KEY_SPACE)):
		# var game_scene = preload("res://game.tscn").instantiate()
		var scene_tree = get_tree()
		scene_tree.change_scene_to_file("res://game.tscn")
		# get_tree().root.add_child(game_scene)

	pass
