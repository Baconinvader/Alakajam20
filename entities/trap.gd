extends Entity

## Generic class for traps

@export var trigger_time:float = 5.0

## Override this as required, called whenever a loop reset occurs
func reset_loop():
	if trigger_time:
		var t:Tween = create_tween()
		t.tween_interval(trigger_time)
		t.tween_callback(trigger)
	
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
