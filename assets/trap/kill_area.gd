extends Area2D

class_name KIllArea

@export var enabled:bool:set=_set_enabled

@export var kill_player:bool = true
@export var kill_enemy:bool = true

func _set_enabled(val:bool):
	enabled = val
	set_deferred("monitoring",enabled)

	#pass
	print(enabled," ",monitoring)

func _on_body_entered(body):
	if get_parent() is Entity and get_parent().freed_loop:
		return
		
	if kill_player:
		if body == g.player:
			g.player.die()
	if kill_enemy:
		if body is Enemy:
			body.die()
