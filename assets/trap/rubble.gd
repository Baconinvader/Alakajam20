extends Entity

## Rubble that appears and blocks a path

class_name Rubble

var appear_tween:Tween = null
@export var fall_time:float = 1.0
@export var fall_height:float = 32

## Not a trap, but triggers anyways
func trigger():
	
	$shape.disabled = false
	
	if appear_tween:
		appear_tween.kill()
		
	
	appear_tween = create_tween()
	
	$static_sprite.position.y -= fall_height
	appear_tween.set_parallel(true)
	appear_tween.tween_property(self, "modulate:a", 1.0, fall_time)
	appear_tween.tween_property($static_sprite, "position:y", 0.0, fall_time)
		
	
func reset_loop():
	super.reset_loop()
	modulate.a = 0.0
