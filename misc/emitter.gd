class_name Emitter extends Node2D

signal spawn

static var options = [
	{
		'name': 'Bug A',
		'scene_path': 'res://bug/bugA.tscn'
	},
	{
		'name': 'Bug B',
		'scene_path': 'res://bug/bugB.tscn'
	},
	{
		'name': 'Empty canister',
		'scene_path': 'res://misc/canister/empty_canister.tscn'
	},
	{
		'name': 'Full canister',
		'scene_path': 'res://misc/canister/full_canister.tscn'
	},
	{
		'name': 'Chemials',
		'scene_path': 'res://misc/chemicals/chemicals.tscn'
	}
]

enum Choice {BUGA, BUGB, CANISTER, FULLCANISTER, CHEMICALS}

@export var choice : Choice = Choice.BUGA
@export var delay : float = 60
var last_spawn_time = 0
var scene
var can_spawn : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene_path = options[choice].scene_path
	scene = load(scene_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	last_spawn_time += delta
	if (can_spawn and last_spawn_time >= delay):
		spawn.emit(scene)
		last_spawn_time = 0
