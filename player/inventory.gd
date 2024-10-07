class_name Inventory extends Node2D

var inventory : Array
var max_items : int
var item_count : int = 0

func _init(l_max_items = 3):
	max_items = l_max_items
	
func _ready():
	inventory = []
	
func _process(delta):
	var i = 1
	for item in inventory:
		
		i += 1

func add_item(item):
	if (!is_full()):
		inventory.append(item.duplicate())
		item_count += 1
	
	refresh_labels()
	
func remove_item(item):
	var index = inventory.find(item)
	if (index != -1):
		inventory.remove_at(index)
		item_count -= 1
		
	refresh_labels()

func has_item(item):
	return item in inventory
	#
func get_items():
	return inventory
	
func get_items_in_group(group : String) -> Array:
	var items : Array = []
	for item in get_items():
		if (item.is_in_group(group)):
			items.append(item)
			
	return items
	
func is_full():
	return item_count >= max_items
	
func refresh_labels():
	for index in range(0, max_items):
		if (index < item_count):
			var item = inventory[index]
			if (item != null):
				set_inventory_label(index, item.title)
		else:
			set_inventory_label(index, '')
	
	
func set_inventory_label(index : int, label_string : String):
	var label_name = 'CanvasLayer/Label' + str(index+1)
	var label = get_node(label_name)
	label.text = label_string
