class_name Inventory extends Node2D

@export var player : Node2D
var inventory : Array = []
var max_items : int
var item_count : int = 0

func _init(l_max_items = 3):
	max_items = l_max_items
	
func _ready():
	pass
	
func _process(delta):
	
	var i = 0
	for item in inventory:
		var label = get_node('Label'+i)
		label.text = item.title
		i += 1

func add_item(item):
	if (!is_full()):
		inventory.append(item)
		item_count += 1
	
func remove_item(item):
	#find item
	item_count -= 1

func has_item(item):
	return item in inventory
	
func is_full():
	return item_count >= max_items
