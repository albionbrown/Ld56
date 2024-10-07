class_name Gas extends CPUParticles2D

const gas_bubble_file = preload("res://player/gas_bubble.tscn")

var gas_bubble_scene
var random_number_generator

# Called when the node enters the scene tree for the first time.
func _ready():
	gas_bubble_scene = load('res://player/gas_bubble.tscn')
	random_number_generator = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (emitting):
		var gas_bubble : RigidBody2D = gas_bubble_scene.instantiate()
		gas_bubble.global_position = global_position
		#gas_bubble.rotation = rotation
		gas_bubble.duration = lifetime
		gas_bubble.show()
		var angle = (get_global_mouse_position() - global_position).normalized() * (initial_velocity_max * 2)
		gas_bubble.apply_central_impulse(angle)
		
		var root = get_tree().root.get_child(0)
		get_tree().root.get_child(0).add_child(gas_bubble)
	pass
