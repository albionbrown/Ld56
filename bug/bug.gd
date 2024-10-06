class_name Bug extends CharacterBody2D

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

	if (in_gas and in_gas.emitting):
		health = health - 1
	
	if (health == 0 and !is_dead):
		is_dead = true
		queue_free()
		

func _on_area_2d_area_entered(area:Area2D):
	if (area.get_parent().is_in_group('gas')):
		in_gas = area.get_parent();


func _on_area_2d_area_exited(area):
	if (area.get_parent().is_in_group('gas')):
		in_gas = false;


func _on_detection_area_player_entered(body):
	if (body.is_in_group('player')):
		noticed_player = true


func _on_detection_area_player_exited(body):
	if (body.is_in_group('player')):
		noticed_player = false
