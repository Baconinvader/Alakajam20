extends Creature

## Player
class_name Player

## Area used to check if the player is in range of an object to interact with
@onready var interaction_area = $interaction_area

## Whatever we are currently interacting with
var interacting

func _physics_process(_delta):
	super._physics_process(_delta)
	
	move_dir = Vector2(0.0,0.0)
	if Input.is_action_pressed("move_up"):
		move_dir += Vector2(0.0,-1.0)
	if Input.is_action_pressed("move_down"):
		move_dir += Vector2(0.0,1.0)
	if Input.is_action_pressed("move_left"):
		move_dir += Vector2(-1.0,0.0)
	if Input.is_action_pressed("move_right"):
		move_dir += Vector2(1.0,0.0)
	move_dir = move_dir.normalized()
		
		
func reset_loop():
	super.reset_loop()
	position = g.level.player_spawn.position

func die():
	super.die()
	g.main.reset_loop()
	
