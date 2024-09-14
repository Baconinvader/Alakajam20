extends Entity

class_name Switch

var on:bool = false:set=_set_on

@export var off_tex:Texture2D
@export var on_tex:Texture2D

@export var direct_switch:bool = true

signal on_changed

func _set_on(val:bool):
	var old_val:bool = on
	on = val
	if on:
		$static_sprite.texture = on_tex
	else:
		$static_sprite.texture = off_tex
		
	if old_val != on:
		on_changed.emit()

func reset_loop():
	super.reset_loop()
	on = false

func interact():
	super.interact()
	if direct_switch:
		on = not on
	
