class_name Bug extends CharacterBody2D

signal dead

var target : Player
var in_gas = false
var is_dead = false
@export var health = 100
@export var does_damage = 10
var animated_sprite : AnimatedSprite2D
var noticed_player : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite = get_node("AnimatedSprite2D")
	target = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (!animated_sprite.is_playing()):
		animated_sprite.play()
	
	if (noticed_player):
		look_at(target.global_position)
		global_position = global_position.lerp(target.global_position, 0.01)
		move_and_slide()
	
	if (is_dead):
		var bug_counter = get_tree().get_first_node_in_group('bug_kill_counter')
		bug_counter.increase()
		queue_free()


func _on_detection_area_player_entered(body):
	if (body.is_in_group('player')):
		noticed_player = true


func _on_detection_area_player_exited(body):
	if (body.is_in_group('player')):
		noticed_player = false

		
func damage(damage):
	health -= damage
	if (health <= 0):
		health = 0
		is_dead = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group('gas_bubble')):
		damage(body.damage)
