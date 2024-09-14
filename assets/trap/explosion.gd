extends Node2D

## Explosion object that deals damage and breaks stuff
class_name Explosion

@export var radius:float = 2.0

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
	
	for x:int in range(radius*2):
		for y:int in range(radius*2):
			var rel_pos:Vector2 = Vector2(x-radius, y-radius)
			if rel_pos.length() <= radius:
				affected_tile_coords.append(topleft_coords+Vector2i(x,y))
				affected_tiles.append( tiles.get_cell_tile_data(0, topleft_coords+Vector2i(x,y)) )
			
	return {'coords':affected_tile_coords, 'data':affected_tiles}
	
## Actually handle the results of the explosion
func do_explosion():
	var tiles:TileMap = g.level.tiles
	
	var td:Dictionary = get_tiles()
	var affected_tiles:Array[TileData] = td['data']
	var tile_coords:Array[Vector2i] = td['coords']
	
	var i:int = 0
	for tile:TileData in affected_tiles:
		if tile:
			var coords:Vector2i = tile_coords[i]
			tiles.set_cell(0, coords, -1)
		#if tile.get_custom_data("breakable"):
		#	tiles.set_cell(0, coords, -1)
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
