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
		
	set_sprite()
		
## Set the direction sprite
func set_sprite():
	if not $sprite.sprite_frames:
		return
	
	var best_dot:float = 0.1
	var best_dir:String = "default"
	var dir_names:Array[String] = ["up","down","left","right",
	"up_left", "up_right", "down_left", "down_right"]
	var dirs:Array[Vector2] = [Vector2(0,-1), Vector2(0,1), Vector2(-1,0), Vector2(1,0),
	Vector2(-1,-1), Vector2(1,-1), Vector2(-1,1), Vector2(1,1)]
	
	var i:int = 0
	for dir:Vector2 in dirs:
		if move_dir.dot(dir) > best_dot:
			best_dot = move_dir.dot(dir)
			best_dir = dir_names[i]
		i += 1
		
	if best_dir != "default":
		$sprite.animation = best_dir
		$sprite.play()
	else:
		$sprite.stop()

	
## Override as required, Called when creature dies
func die():
	free_loop()
