extends Creature

## Base class for enemies

class_name Enemy

@onready var spawn_pos:Vector2 = position
#@export var guard_marker:Marker2D
@export var sight_range:float = 128.0
@export var min_player_dist:float = 48.0

var can_see_player:bool = false

var target:Vector2:set=_set_target
var has_target:bool = false

func _set_target(val):
	var old_target:Vector2 = target
	if old_target != val:
		target = val
		$nav.target_position = target
		

func reset_loop():
	super.reset_loop()
	position = spawn_pos
	has_target = false
	$nav.target_position = spawn_pos


func _physics_process(delta):
	var player_dist:float = position.distance_to(g.player.position)
	if player_dist <= sight_range:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(position, g.player.position)
		var result:Dictionary = space_state.intersect_ray(query)
		if result and result.collider == g.player:
			can_see_player = true
			target = result.position
			print(result)
			
		else:
			can_see_player = false
			
	if player_dist > min_player_dist and not g.player.interacting:
		if target.distance_to(position) < move_speed*delta:
			position = target
			move_dir = Vector2.ZERO
		else:
			var next_pos = $nav.get_next_path_position()
			move_dir = (next_pos - position).normalized()
	else:
		move_dir = Vector2.ZERO
	$target.position = $nav.target_position - position
	#print($nav.distance_to_target(), " -> ", $nav.is_target_reached(), ", ", $nav.is_navigation_finished(), ", ", $nav.target_desired_distance)
	
	super._physics_process(delta)

	
func _on_nav_target_reached():
	pass


func _on_nav_navigation_finished():
	if not can_see_player:
		has_target = false
		$nav.target_position = spawn_pos


func _on_attack_area_body_entered(body):
	if body == g.player:
		g.player.die_start()
