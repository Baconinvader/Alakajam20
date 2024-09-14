extends Entity

## Base class for all creature type game objects, mainly the player
class_name Creature

## How fast the creature moves per second
@export var move_speed:float = 96.0


## Direction creature is moving in, should be normalized
var move_dir:Vector2 = Vector2(0,0)

func _physics_process(_delta):
	if not freed_loop:
		velocity = move_dir*move_speed
		move_and_slide()

	
## Override as required, Called when creature dies
func die():
	free_loop()
