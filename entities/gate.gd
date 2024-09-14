extends Entity

## Gate that can be opened via a switch or other means maybe

class_name Gate

@export var switch:Switch = null

@export var start_raised:bool = false
var raised:bool = false

func _ready():
	super._ready()
	if switch:
		switch.connect("on_changed", _on_switch_on_changed)
		
	if start_raised:
		raise()

func _on_switch_on_changed():
	if switch.on:
		raise()
	else:
		lower()

func reset_loop():
	super.reset_loop()
	if start_raised != raised:
		if start_raised:
			raise()
		else:
			lower()
		
		
## Raise the gate
func raise():
	visible = false
	$shape.disabled = true
	raised = true
	
## Lower the gate():
func lower():
	visible = true
	$shape.disabled = false
	raised = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
