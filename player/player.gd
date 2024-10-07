class_name Player extends CharacterBody2D

signal reload

const Usable_class = preload("res://misc/usable.gd")
const Backpack_class = preload("res://player/backpack.gd")
const Inventory_class = preload("res://player/inventory.gd")

@export var health = 100
@export var speed = 400
@export var health_bar : HealthBar
@export var inventory : Inventory
var gas: CPUParticles2D
var backpack : Backpack
var is_dead : bool = false
var current_usable_target

enum State {DEFAULT, RELOADING}
var current_state : State
@export var reload_time : float
var reload_timer : Timer

func _ready():
	gas = get_node('gas')
	backpack = Backpack.new(gas)
	current_state = State.DEFAULT
	reload_timer = Timer.new()
	reload_timer.wait_time = reload_time
	reload_timer.one_shot = true
	reload_timer.connect("timeout", Callable(self, "_on_reload"))
	add_child(reload_timer)
	
func _process(delta):

	if (health == 0):
		is_dead = true
		#emit_signal
		queue_free()
	
	if (current_state == State.DEFAULT):
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			self.backpack.start()
		else:
			self.backpack.stop()
		
		# Ensure the key has been lifted before being used again
		if (Input.is_action_just_pressed('use') and current_usable_target != null):
			if (Usable.is_usable(current_usable_target)):
				current_usable_target.use(inventory)
			elif (!inventory.is_full()):
				pickup(current_usable_target)
		
		if (Input.is_action_just_pressed("reload")):
			current_state = State.RELOADING
			reload_timer.start()
	
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
	if (item.is_in_group('inventory_item')):
		inventory.add_item(item)
		item.pickup()
		unset_usable()
	
func set_usable(l_usable):
	current_usable_target = l_usable
	
func unset_usable():
	current_usable_target = null

func _on_area_2d_area_entered(area):
	if (area.get_parent().is_in_group('bug')):
		health -= area.get_parent().does_damage

func _on_reload() -> void:
	current_state = State.DEFAULT
	reload_canister()

func reload_canister():
	var full_canisters = inventory.get_items_in_group('full_canister')
	if (full_canisters.size() > 0):
		backpack.total = backpack.max_total
		var item = full_canisters.pop_front()
		inventory.remove_item(item)
		item.queue_free()
		
func is_reloading():
	return current_state == State.RELOADING

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group('bug')):
		health -= body.does_damage
