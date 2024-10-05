class_name Player extends CharacterBody2D

@export var health = 100
@export var speed = 400
var gas: CPUParticles2D

func _ready():
	gas = get_node('gas')

func _process(delta):
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		self.gas.emitting = true
	else:
		self.gas.emitting = false

func _physics_process(delta):
	get_input()
	move_and_slide()
	# rotation = get_global_mouse_position().angle_to_point(position) - 180
	look_at(get_global_mouse_position())

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
