extends Node

## Manages reset timer

class_name TimeManager

var do_reset:bool = true

var time:float:get=_get_time
func _get_time() -> float:
	return $timer.time_left

@export var max_time:float:get=_get_max_time,set=_set_max_time
func _get_max_time() -> float:
	return max_time
func _set_max_time(val:float):
	max_time = val
	if $timer:
		$timer.wait_time = max_time


func reset_loop():
	$timer.start()
	

func _on_timer_timeout():
	g.main.reset_loop()
	
func _ready():
	g.time_manager = self
	$timer.wait_time = max_time
