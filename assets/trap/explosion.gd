extends Node2D

## Explosion object that deals damage and breaks stuff
class_name Explosion

@export var radius:float = 3.0

@onready var remover:TileExplosionRemover = $remover

# Called when the node enters the scene tree for the first time.
func _ready():
	remover.radius = radius
	$sprite.visible = true

	
## Actually handle the results of the explosion
func do_explosion():
	$remover.do_removal()
	queue_free()
	
## Setup and execute this explosion
func setup(parent:Node2D):
	position = parent.position
	g.level.explosions.add_child(self)
	do_explosion()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
