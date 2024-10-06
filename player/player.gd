class_name Player extends CharacterBody2D

const Usable_class = preload("res://misc/usable.gd")
const Backpack_class = preload("res://player/backpack.gd")
const Inventory_class = preload("res://player/inventory.gd")

@export var health = 100
@export var speed = 400
@export var health_bar : HealthBar
var gas: CPUParticles2D
var backpack : Backpack
var is_dead : bool = false
var current_usable_target
var inventory : Inventory

func _ready():
	gas = get_node('gas')
	backpack = Backpack.new(gas)
	inventory = Inventory.new()
	
func _process(delta):

	if (health == 0):
		is_dead = true
		#emit_signal
		queue_free()
	
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		self.backpack.start()
	else:
		self.backpack.stop()
		
	if (Input.is_physical_key_pressed(KEY_E) and Usable.is_usable(current_usable_target)):
		current_usable_target.use()
		
	if (Input.is_physical_key_pressed(KEY_E) and !inventory.is_full()):
		pickup(current_usable_target)
		
	backpack._process(delta)
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	# rotation = get_global_mouse_position().angle_to_point(position) - 180
	look_at(get_global_mouse_position())

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func pickup(item):
	item.pickup()
	inventory.add_item(item)
	
func set_usable(l_usable):
	current_usable_target = l_usable
	
func unset_usable():
	current_usable_target = false

func _on_area_2d_area_entered(area):
	if (area.get_parent().is_in_group('bug')):
		health -= area.get_parent().does_damage
