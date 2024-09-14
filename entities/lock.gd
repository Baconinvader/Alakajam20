extends Entity

## Lock that can applied and then unlocked with a key

class_name KeyLock
@export var key_name:String = "key"

signal on_unlocked

func can_interact() -> bool:
	if g.player.item:
		if g.player.item.item_name == key_name:
			return true
		else:
			return false
	else:
		return false
		
func interact():
	super.interact()
	g.player.item = null
	on_unlocked.emit()
	free_loop()
