extends Entity


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $hooks.get_children():
		child.connect("on_placed", _on_hook_placed)

## Check for puzzle update here
func _on_hook_placed():
	if is_puzzle_solved():
		pass
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
