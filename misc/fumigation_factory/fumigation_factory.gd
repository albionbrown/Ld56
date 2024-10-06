class_name FumigationFactory extends AnimatedSprite2D

var has_canister : bool = false
var has_chemicals : bool = false
var progress : int = 0
var in_progress : bool = false
@export var progress_total : int = 1000
@export var progress_rate : int = 1
@export var default_state : String = 'off'
var use_label : RichTextLabel
var add_items_label : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	use_label = get_node('UseLabel')
	use_label.hide()
	
	add_items_label = get_node('AddItemsLabel')
	add_items_label.hide()
	
	play("off")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if (in_progress):
		progress += progress_rate
		
	if (progress >= progress_total):
		in_progress = false
		progress = 0
		play('off')
		has_canister = false
		has_chemicals = false
		# output canister

func add_canister(caniser):
	has_canister = true
	
func add_chemicals(chemicals):
	has_chemicals = true
	
func start():
	if (in_progress):
		pass
		
	in_progress = true
	play('running')

func use(inventory : Inventory):
	# Collect 
	if (!in_progress and !full()):
		var items_to_remove = []
		for item in inventory.get_items():
			if (item.is_in_group('fumigation_item')):
				item.move(self)
				items_to_remove.append(item)
#				# Consume the item
				#item.queue_free()
				
		for item in items_to_remove:
			inventory.remove_item(item)
			item.queue_free()
				
	elif (!in_progress and full()):
		start()
		use_label.hide()
	
func can_be_used():
	return !in_progress

func _on_area_2d_body_entered(body):
	if (body.is_in_group('player')):
		body.set_usable(self)
		
		if (!in_progress and full()):
			use_label.show()
		
		if (!in_progress and body.inventory.get_items_in_group('fumigation_item')):
			add_items_label.show()


func _on_area_2d_body_exited(body):
	if (body.is_in_group('player')):
		use_label.hide()
		add_items_label.hide()
		body.unset_usable()
		
func full():
	return has_canister and has_chemicals
