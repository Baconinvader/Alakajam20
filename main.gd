extends Node

class_name Main

## Everything part of the "game" game should be a child of this layer
@onready var game_layer:Node2D = $game

## Everything part of the "UI" part of the game should be a child of this layer
@onready var ui_layer:CanvasLayer = $UI

func _ready():
	#calling this automatically for now
	start_game()


## Start the actual game loop, probably will be called when a button is pressed
func start_game():
	g.main = self
	g.level = load("res://level.tscn").instantiate()
	g.player = load("res://entities/player.tscn").instantiate()
	$game.add_child(g.level)
	g.level.add_child(g.player)
	reset_loop()
	
## Reset everything
func reset_loop():
	g.level.reset_loop()
