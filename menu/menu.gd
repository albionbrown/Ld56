class_name Menu extends Node2D

var start = false
var loading_label : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	loading_label = get_node('RichTextLabel2')
	loading_label.hide()
	start = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if (start):
		var scene_tree = get_tree()
		scene_tree.change_scene_to_file("res://game.tscn")
	
	if (Input.is_action_just_pressed("space")):
		loading_label.show()
		start = true
	
