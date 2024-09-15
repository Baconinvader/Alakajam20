extends Entity

class_name ItemEntity

@export var item:Item:set=_set_item
@export var item_scene:PackedScene

## If set, is reset during loop_reset. Otherwise, deleted
@export var original:bool = true
@onready var original_item:Item = item

func _set_item(val:Item):
	item = val
	if not item:
		visible = false
	else:
		visible = true
		$static_sprite.texture = item.tex
		
func _ready():
	if item_scene:
		item = item_scene.instantiate()
		original_item = item
		
func reset_loop():
	if original:
		super.reset_loop()
		item = original_item
	else:
		queue_free()
		
func interact():
	super.interact()
	if g.player.item:
		g.player.drop_item()
	g.player.item = item
	item = null
	
		
func can_interact() -> bool:
	if not super.can_interact():
		return false
	if not item:
		return false
	return true
		
## Pickup the item
func pickup():
	g.player.item = item
	queue_free()
