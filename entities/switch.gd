extends Entity

class_name Switch

var on:bool = false:set=_set_on

@export var off_tex:Texture2D
@export var on_tex:Texture2D

func _set_on(val:bool):
	on = val
	if on:
		$static_sprite.texture = on_tex
	else:
		$static_sprite.texture = off_tex

func interact():
	super.interact()
	on = not on
	
