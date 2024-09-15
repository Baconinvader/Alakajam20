extends Node

class_name Main

## Everything part of the "game" game should be a child of this layer
@onready var game_layer:Node2D = $game

## Everything part of the "UI" part of the game should be a child of this layer
@onready var ui_layer:CanvasLayer = $UI

func _ready():
	g.main = self
	add_start_screen()

## Fully reset player/level
func reset():
	if g.level:
		g.level.queue_free()
	if g.player:
		g.player.queue_free()
	g.level = load("res://level.tscn").instantiate()
	g.player = load("res://entities/player.tscn").instantiate()
	$game.add_child(g.level)
	g.level.add_child(g.player)

## Create start screen
func add_start_screen():
	var start_screen:StartScreen = load("res://UI/start_screen.tscn").instantiate()
	ui_layer.add_child(start_screen)
	
## Create win screen
func add_win_screen():
	var win_screen:WinScreen = load("res://UI/win_screen.tscn").instantiate()
	ui_layer.add_child(win_screen)

## Start the actual game loop, probably will be called when a button is pressed
func start_game():
	reset()
	reset_loop()
	
## Reset everything
func reset_loop():
	g.level.reset_loop()
