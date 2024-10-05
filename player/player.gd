class_name Player extends CharacterBody2D

const Backpack_file = preload("res://player/backpack.gd")

@export var health = 100
@export var speed = 400
var gas: CPUParticles2D
var backpack : Backpack

func _ready():
	self.gas = get_node('gas')
	self.backpack = Backpack.new(gas)

func _process(delta):

	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		self.backpack.start()
	else:
		self.backpack.stop()
		
	backpack._process(delta)

func _physics_process(delta):
	get_input()
	move_and_slide()
	# rotation = get_global_mouse_position().angle_to_point(position) - 180
	look_at(get_global_mouse_position())

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
