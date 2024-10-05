class_name Backpack

@export var gas : CPUParticles2D
@export var total : int = 100
@export var valve : int = 1
@export var canisters : Array

func _init(l_gas : CPUParticles2D):
	self.gas = l_gas

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (gas.emitting):
		total = total - valve
		
	if (total == 0):
		stop()

# Start fumigating
func start():
	if (total > 0):
		self.gas.emitting = true
	
# Stop fumigating
func stop():
	self.gas.emitting = false
	
func set_gas(l_gas : CPUParticles2D):
	self.gas = l_gas
