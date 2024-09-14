extends Node

## Used for dialogue/timeline handling


func _ready():
	Dialogic.connect("timeline_started", _on_timeline_started)
	Dialogic.connect("timeline_ended", _on_timeline_ended)

func _on_timeline_started():
	g.player.interacting = g.interacting

func _on_timeline_ended():
	g.player.interacting = null

func _process(delta):
	pass
