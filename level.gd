extends Node2D

class_name Level

## Using this to organise all the markers in the level, generic
@onready var markers:Node2D = $markers
## Add entities here
@onready var entities:Node2D = $entities
## Where to position the player
@onready var player_spawn:Marker2D = $markers/spawn
## Add explosions here
@onready var explosions:Node2D = $explosions


## Torture room
@onready var torture_room:Node2D = $entities/torture_room
## Kitchen room
@onready var kitchen_room:Node2D = $entities/kitchen_room

@onready var bg_m = $level_bg_music
@onready var tiles:TileMap = $tiles

func _ready():
	bg_m.play()

## Reset all the resetable stuff for the next loop
func reset_loop():
	for obj in get_tree().get_nodes_in_group("reset"):
		if obj.do_reset:
			if "frozen" in obj:
				if obj.frozen:
					#obj.frozen = false
					obj.reset_loop_frozen()
				else:
					obj.reset_loop()
			else:
				obj.reset_loop()
				
	#softlock prevention, bit of a hack
	var valve:Valve = $entities/stairs_room/valve
	var side_gate:Gate = $entities/hallways/side_gate
	if not side_gate.raised and valve.on:
		valve.frozen = false
		valve.on = false
