extends Node2D

## Class used for temporary removal of tiles
class_name TileRemover

@export var width:float = 2
@export var height:float = 2

## Keep track of the affected tiles so can be reset
var last_affected_tiles:Dictionary = {'coords':[], 'data':[], 'atlas':[]}

var do_reset:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

## Override to provide additional criteria for removal
func meets_criteria(rel_pos:Vector2, td:TileData) -> bool:
	return true

## Get the tiles caught in this explosion
func get_tiles() -> Dictionary:
	var tiles:TileMap = g.level.tiles
	var topleft:Vector2 = get_parent().position - Vector2(width*tiles.tile_set.tile_size.x*0.5, height*tiles.tile_set.tile_size.y*0.5)
	
	var topleft_coords:Vector2i = tiles.local_to_map(topleft)
	var affected_tiles:Array[TileData] = []
	var affected_tile_coords:Array[Vector2i] = []
	var affected_tile_atlas:Array[Vector2i] = []
	
	for x:int in range(width):
		for y:int in range(height):
			var rel_pos:Vector2 = Vector2(x-(width*0.5), y-(height*0.5))

			var tp:Vector2i = topleft_coords+Vector2i(x,y)
			var td:TileData = tiles.get_cell_tile_data(0, tp)
			
			if td:
				if not meets_criteria(rel_pos, td):
					continue
			
				affected_tile_coords.append(tp)
				affected_tiles.append( td )
				affected_tile_atlas.append( tiles.get_cell_atlas_coords(0, tp) )
			
	last_affected_tiles = {'coords':affected_tile_coords, 'data':affected_tiles, 'atlas':affected_tile_atlas}
	return last_affected_tiles
	
## Actually handle the results of tile removal
func do_removal():
	var tiles:TileMap = g.level.tiles
	
	var td:Dictionary = get_tiles()
	var affected_tiles:Array[TileData] = td['data']
	var tile_coords:Array[Vector2i] = td['coords']
	
	var i:int = 0
	for tile:TileData in affected_tiles:
		
		var coords:Vector2i = tile_coords[i]
		#tiles.set_cell(0, coords, -1)
		if tile.get_custom_data("breakable"):
			tiles.set_cell(0, coords, -1)
		i += 1
	
	
	
func reset_loop():
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

