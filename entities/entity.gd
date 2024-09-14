extends CharacterBody2D

## Base class for all game objects
class_name Entity

## Whether this object should be reset during a loop
@export var do_reset:bool = true

## Override this as required, called whenever a loop reset occurs
func reset_loop():
	pass
	
## Override this as required, called whenever interaction occurs
func interact():
	pass
	
## Override this as required, checks if this object
func can_interact() -> bool:
	return true

