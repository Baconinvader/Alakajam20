extends Trap

var last_affected_tiles:Dictionary = {'coords':[], 'data':[], 'atlas':[]}

## Override this as required, called when the trap triggers
func trigger():
	var explosion:Explosion = load("res://assets/trap/explosion.tscn").instantiate()
	explosion.setup(self)
	last_affected_tiles = explosion.last_affected_tiles
	free_loop()
	
func reset_loop():
	super.reset_loop()
	
	#restore broken tiles
	var tiles:TileMap = g.level.tiles
	var affected_tiles:Array = last_affected_tiles['data']
	var tile_coords:Array = last_affected_tiles['coords']
	var tile_atlas:Array = last_affected_tiles['atlas']
	var i:int = 0
	for tile:TileData in affected_tiles:
		var coords:Vector2i = tile_coords[i]
		var atlas:Vector2i = tile_atlas[i]
		
		if tile.get_custom_data("breakable"):
			#restore
			tiles.set_cell(0, coords, 0, atlas)
		i += 1

	
