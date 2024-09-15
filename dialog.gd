extends Node

## Used for dialogue/timeline handling


func _ready():
	Dialogic.connect("timeline_started", _on_timeline_started)
	Dialogic.connect("timeline_ended", _on_timeline_ended)

func _on_timeline_started():
	g.player.interacting = g.interacting

func _on_timeline_ended():
	g.player.interacting = null

func basic_dialogue(text:String):
	if text.is_empty():
		return
		
	var events: Array = text.split('\n')

	var timeline : DialogicTimeline = DialogicTimeline.new()
	timeline.events = events
	Dialogic.start(timeline)

func _process(delta):
	pass
