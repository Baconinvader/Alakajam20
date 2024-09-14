extends Control

class_name TimeView

func _ready():
	$bar.max_value = g.time_manager.max_time

func _process(delta):
	var sec:int = int(g.time_manager.time) % 60
	var min:int = int(g.time_manager.time / 60)
	var ds = floori( fmod(g.time_manager.time, 1.0)*10 )
	$time.text = "%02d:%02d:%01d" % [min, sec, ds]
	
	$bar.value = g.time_manager.time
