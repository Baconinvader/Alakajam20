extends Trap

@export var rubble:Rubble

var last_affected_tiles:Dictionary = {'coords':[], 'data':[], 'atlas':[]}

var remover:TileExplosionRemover = null

var armed:bool = true:set=_set_armed
func _set_armed(val:bool):
	armed = val
	if armed:
		$sprite.play("armed")
		setup_trigger_tween()
	else:
		$sprite.play("disarmed")
		
## Override this as required, called when the trap triggers
func trigger():
	if armed:
		var explosion:Explosion = load("res://assets/trap/explosion.tscn").instantiate()
		explosion.setup(self)
		#bit of a hack
		remover = explosion.remover.duplicate()
		remover.last_affected_tiles = explosion.remover.last_affected_tiles

		free_loop()
		
		if rubble:
			rubble.trigger()
	
func reset_loop():
	super.reset_loop()
	armed = true
	$sprite.play()
	if remover:
		remover.reset_loop()
		remover = null
	
func interact():
	super.interact()
	armed = not armed
	
	
