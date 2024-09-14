extends "res://entities/trap.gd"

var sprite_y:float = -128
var fall_time:float = 1.0

var fall_tween:Tween = null

func reset_loop():
	super.reset_loop()
	$kill_area.enabled = false
	
	$static_sprite.position.y = sprite_y

## Override this as required, called when the trap triggers
func trigger():
	if fall_tween:
		fall_tween.kill()
	fall_tween = create_tween()
	fall_tween.tween_property($static_sprite, "position:y", 0, fall_time)
	fall_tween.tween_property($kill_area, "enabled", true, 0)
	
