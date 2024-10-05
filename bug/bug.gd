class_name Bug extends CharacterBody2D

var target : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target = get_tree().get_first_node_in_group("player")
	global_position = global_position.lerp(target.global_position, 0.01)
	move_and_slide()
