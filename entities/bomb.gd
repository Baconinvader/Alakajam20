extends Trap

var last_affected_tiles:Dictionary = {'coords':[], 'data':[], 'atlas':[]}

var remover:TileExplosionRemover = null

## Override this as required, called when the trap triggers
func trigger():
	var explosion:Explosion = load("res://assets/trap/explosion.tscn").instantiate()
	explosion.setup(self)
	#bit of a hack
	remover = explosion.remover.duplicate()
	remover.last_affected_tiles = explosion.remover.last_affected_tiles

	free_loop()
	
func reset_loop():
	super.reset_loop()
	if remover:
		remover.reset_loop()
		remover = null
	
	
	
