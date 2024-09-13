extends Area2D

## Interaction area, add this to an object that can be interacted with
class_name InteractArea

## The object this is attached to
@onready var obj:Node2D = get_parent()

## Whether the player is close enough to this area to interact with it's object
var in_range:bool = false

const marker_move_time:float = 2.0


## Whether the player can interact with the area
var player_can_interact:bool:set=_set_player_can_interact
func _set_player_can_interact(val:bool):
	var old_val = player_can_interact
	player_can_interact = val
	if old_val != player_can_interact:
		if player_can_interact:
			$marker.visible = true
		else:
			$marker.visible = false

## Makes the marker go up and down
func create_move_marker_tween():
	var t:Tween = create_tween()
	t.tween_property($marker, "position:y", 16, marker_move_time*0.5)
	t.tween_property($marker, "position:y", -16, marker_move_time*0.5)
	t.tween_callback(create_move_marker_tween)

func _ready():
	$marker.visible = false
	player_can_interact = false
	create_move_marker_tween()

func _physics_process(_delta):
	if in_range:
		if can_interact():
			player_can_interact = true
		else:
			player_can_interact = false
	else:
		player_can_interact = false

## Whether the interaction conditions for this area are met
func can_interact() -> bool:
	return obj.can_interact()

## Called during interaction
func interact():
	obj.interact()


func _on_area_entered(area):
	if area == g.player.interaction_area:
		in_range = true
	

func _on_area_exited(area):
	if area == g.player.interaction_area:
		in_range = false

func _input(ev:InputEvent):
	if player_can_interact:
		if ev.is_action_pressed("interact"):
			interact()
