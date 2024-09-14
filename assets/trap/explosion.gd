extends Node2D

## Explosion object that deals damage and breaks stuff
class_name Explosion

@export var radius:float = 2.0

## Keep track of the affected tiles so can be reset
var last_affected_tiles:Dictionary = {'coords':[], 'data':[], 'atlas':[]}

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.visible = true

## Get the tiles caught in this explosion
func get_tiles() -> Dictionary:
	var tiles:TileMap = g.level.tiles
	
	
	var topleft:Vector2 = position - Vector2(radius*tiles.tile_set.tile_size.x, radius*tiles.tile_set.tile_size.y)
	
	var topleft_coords:Vector2i = tiles.local_to_map(topleft)
	var affected_tiles:Array[TileData] = []
	var affected_tile_coords:Array[Vector2i] = []
	var affected_tile_atlas:Array[Vector2i] = []
	
	for x:int in range(radius*2):
		for y:int in range(radius*2):
			var rel_pos:Vector2 = Vector2(x-radius, y-radius)
			if rel_pos.length() <= radius:
				var tp:Vector2i = topleft_coords+Vector2i(x,y)
				var td:TileData = tiles.get_cell_tile_data(0, tp)
				
				if td:
					affected_tile_coords.append(tp)
					affected_tiles.append( td )
					affected_tile_atlas.append( tiles.get_cell_atlas_coords(0, tp) )
			
	last_affected_tiles = {'coords':affected_tile_coords, 'data':affected_tiles, 'atlas':affected_tile_atlas}
	return last_affected_tiles
	
## Actually handle the results of the explosion
func do_explosion():
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
	
	queue_free()
	
## Setup and execute this explosion
func setup(parent:Node2D):
	position = parent.position
	g.level.explosions.add_child(self)
	do_explosion()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
