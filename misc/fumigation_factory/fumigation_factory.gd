class_name fumigation_factory extends AnimatedSprite2D

var has_canister : bool = false
var has_chemicals : bool = false
var progress : int = 0
var in_progress : bool = false
@export var progress_total : int = 1000
@export var progress_rate : int = 1
@export var default_state : String = 'off'
var use_label : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	use_label = get_node('RichTextLabel')
	use_label.hide()
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
		print('Done!')
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

func use():
	start()
	use_label.hide()
	
func can_be_used():
	return !in_progress

func _on_area_2d_body_entered(body):
	if (body.is_in_group('player')):
		if (!in_progress):
			use_label.show()
			
		body.set_usable(self)


func _on_area_2d_body_exited(body):
	if (body.is_in_group('player')):
		use_label.hide()
		body.unset_usable()
