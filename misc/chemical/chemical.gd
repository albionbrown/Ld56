class_name chemical extends Node2D

@export var title : String
var label
var emitter

# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node('Label')
	label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_player_entered(body):
	if (body.is_in_group('player')):
		if (body.current_usable_target != self):
			body.set_usable(self) 
			label.show()

func _on_area_2d_player_exited(body):
	if (body.is_in_group('player')):
		if (body.current_usable_target == self):
			body.unset_usable()
			label.hide()

func pickup():
	hide()
	label.hide()
	if (emitter != null):
		emitter.clear()

func use():
	pass
	
func move(node):
	node.add_chemicals(self)
