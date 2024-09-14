extends CharacterBody2D

## Base class for all game objects
class_name Entity

## Whether this object should be reset during a loop
@export var do_reset:bool = true

@export var start_collidable:bool = true
@export var start_visible:bool = true
@export var is_static:bool = true

## Override this as required, called whenever a loop reset occurs
func reset_loop():
	visible = true
	$shape.disabled = not start_collidable
	
func _ready():
	if is_static:
		collision_mask = 0b00000000_00000000_00000000_00000000
	else:
		collision_mask = 0b00000000_00000000_00000000_00000001
	
func _physics_process(_delta):
	if not is_static:
		move_and_slide()
	
## Override this as required, use this instead of queue_free
## when you need to remove an object for a single loop
func free_loop():
	visible = false
	$shape.disabled = true
	
## Override this as required, called whenever interaction occurs
func interact():
	pass
	
## Override this as required, checks if this object
func can_interact() -> bool:
	return true

