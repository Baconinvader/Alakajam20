extends Entity

## Generic class for traps
class_name Trap

@export var trigger_time:float = 5.0

## Tween that activates the trap on a timer
var trigger_tween:Tween = null

## Override this as required, called whenever a loop reset occurs
func reset_loop():
	super.reset_loop()
	setup_trigger_tween()
	
## Create the timer to eventually set off this trap
func setup_trigger_tween():
	if trigger_time:
		if trigger_tween:
			trigger_tween.kill()
			
		trigger_tween = create_tween()
		trigger_tween.tween_interval(trigger_time)
		trigger_tween.tween_callback(trigger)
	
func _ready():
	pass
	
## Override this as required, called when the trap triggers
func trigger():
	pass
	
## Override this as required, called whenever interaction occurs
func interact():
	pass
	
## Override this as required, checks if this object
func can_interact() -> bool:
	return true
