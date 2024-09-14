extends Area2D

class_name KIllArea

@export var enabled:bool:set=_set_enabled

func _set_enabled(val:bool):
	enabled = val
	set_deferred("monitoring",enabled)

	#pass
	print(enabled," ",monitoring)

func _on_body_entered(body):
	if body == g.player:
		g.player.die()
