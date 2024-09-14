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

@onready var tiles:TileMap = $tiles

## Reset all the resetable stuff for the next loop
func reset_loop():
	for obj in get_tree().get_nodes_in_group("reset"):
		if obj.do_reset:
			obj.reset_loop()
