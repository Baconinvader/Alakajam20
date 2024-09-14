extends TileRemover

## Class used for temporary removal of tiles
class_name TileExplosionRemover

@export var radius:float = 1.0:set=_set_radius

func _set_radius(val):
	radius = val
	width = radius+2
	height = radius*2


## Override to provide additional criteria for removal
func meets_criteria(rel_pos:Vector2, td:TileData) -> bool:
	if not super.meets_criteria(rel_pos, td):
		return false
		
	if rel_pos.length() <= radius:
		return true
	else:
		return false
		
func do_removal():
	super.do_removal()
	queue_free()

