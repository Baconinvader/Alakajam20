extends Node

## Used for dialogue/timeline handling


func _ready():
	Dialogic.connect("timeline_ended", _on_timeline_ended)

func _on_timeline_ended():
	g.player.interacting = null

func _process(delta):
	pass
