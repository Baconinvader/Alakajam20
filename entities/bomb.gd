extends Trap


## Override this as required, called when the trap triggers
func trigger():
	var explosion:Explosion = load("res://assets/trap/explosion.tscn").instantiate()
	explosion.setup(self)
	queue_free()
	
