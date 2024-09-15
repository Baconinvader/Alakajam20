extends Entity

## Entity that an item can be deposited into
class_name ItemPlace

var item:Item = null:set=_set_item
func _set_item(val:Item):
	item = val
	if item:
		$static_sprite.visible = true
		$static_sprite.texture = item.tex
		on_placed.emit()
	else:
		$static_sprite.visible = false
		on_removed.emit()

## if not empty, item name must match to be able to place
@export var item_name:String = ""
@export var item_tags:Array[String] = []


## Can we remove this item and put it back into the player's inventory
@export var can_remove:bool = true

signal on_placed
signal on_removed

func reset_loop():
	super.reset_loop()
	item = null
	
func reset_loop_frozen():
	item = item

## Whether or not an item can be placed
func item_is_valid(item:Item) -> bool:
	if not item_name.is_empty() and g.player.item.item_name != item_name:
		return false
		
	var matching_tag:bool = false
	if item_tags.is_empty():
		matching_tag = true
	for tag:String in item_tags:
		for item_tag:String in item.tags:
			if item_tag == tag:
				matching_tag = true
				break
		if matching_tag:
			break
	if not matching_tag:
		return false
		
	return true
				

func can_interact() -> bool:
	if g.player.item:
		if item_is_valid(g.player.item):
			return true
		else:
			return false
	else:
		if item and can_remove:
			return true
		else:
			return false
		
func interact():
	super.interact()
	
	if item:
		if g.player.item:
			#swap
			var t_item:Item = g.player.item
			g.player.item = item
			item = t_item
		else:
			#remove
			g.player.item = item
			item = null
	else:
		if g.player.item:
			#place
			item = g.player.item
			g.player.item = null
	
	
