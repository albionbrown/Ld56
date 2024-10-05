class_name Player extends CharacterBody2D

@export var health = 100
@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	rotation = get_global_mouse_position().angle_to_point(position)
