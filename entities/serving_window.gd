extends Entity

## Handler for the overall kitchen/dining/serving puzzle

@export var tables:Array[KitchenTable] = []
@export var key:ItemEntity

# Called when the node enters the scene tree for the first time.
func _ready():
	for table:KitchenTable in tables:
		table.connect("on_placed", _on_table_placed)
		
## Check for puzzle update here
func _on_table_placed():
	if is_puzzle_solved():
		d.basic_dialogue("Looks like that's all of them.")
		key.position = position
		key.visible = true
	else:
		pass
	
## Has the food been placed correctly
func is_puzzle_solved() -> bool:
	for table:KitchenTable in tables:
		if not table.item:
			return false
	return true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
