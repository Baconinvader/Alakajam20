extends Entity

@export var tile_remover:SimpleRemover

@export var meat_entity1:ItemEntity = null
@export var meat_entity2:ItemEntity = null
@export var meat_entity3:ItemEntity = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $hooks.get_children():
		child.connect("on_placed", _on_hook_placed)

func reset_loop():
	super.reset_loop()
	
func reset_loop_frozen():
	super.reset_loop_frozen()
	#var removed_entities = []
	#for child in $hooks.get_children():
	#	if child.item:
	#		for meat_entity:ItemEntity in [meat_entity1,meat_entity2,meat_entity3]:
	#			print(meat_entity.item, " -> ", child.item)
	#			if meat_entity and meat_entity.item == child.item:
	#				meat_entity1.free_loop()
	#				meat_entity1.do_reset = false
	#				removed_entities.append(meat_entity1)
	#				
	#for ent in [meat_entity1,meat_entity2,meat_entity3]:
	#	if not ent in removed_entities:
	#		meat_entity1.do_reset = true
		

## Check for puzzle update here
func _on_hook_placed():
	if is_puzzle_solved():
		d.basic_dialogue("Looks like placing them in the correct order opened something up.")
		tile_remover.do_removal()
	else:
		pass
	
## Has the MEAT been placed correctly
func is_puzzle_solved() -> bool:
	var child_index:int = 0
	for child in $hooks.get_children():
		if not child.item:
			return false
		
		var correct_meat:bool = false
		if child_index == 0 and child.item.item_name == "meat0":
			correct_meat = true
		elif child_index == 1 and child.item.item_name == "meat1":
			correct_meat = true
		elif child_index == 2 and child.item.item_name == "meat2":
			correct_meat = true
		
		if not correct_meat:
			return false
		
		child_index += 1
	return true

func _on_frozen():
	super._on_frozen()
	if frozen:
		for child in $hooks.get_children():
			child.frozen = true
	else:
		for child in $hooks.get_children():
			child.frozen = false
	

func can_freeze() -> bool:
	return true
	
func can_interact() -> bool:
	return false
