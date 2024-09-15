extends Node2D

## Explosion object that deals damage and breaks stuff
class_name Explosion

@export var radius:float = 3.0

@onready var remover:TileExplosionRemover = $remover

var explosion_time:float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	remover.radius = radius
	$sprite.visible = true
	$kill_area/shape.shape.radius = radius*32.0
	$kill_area.enabled = false

	
## Actually handle the results of the explosion
func do_explosion():
	var dist:float = position.distance_to(g.player.position)
	if dist <= radius*32.0:
		g.player.die_start()
		
	var t:Tween = create_tween()
	#t.tween_property($kill_area, "enabled", true, explosion_time*0.25)
	#t.tween_property($kill_area, "enabled", false, explosion_time*0.75)
	t.tween_interval(explosion_time)
	$remover.do_removal()
	$sprite.play()
	
## Setup and execute this explosion
func setup(parent:Node2D):
	position = parent.position
	g.level.explosions.add_child(self)
	do_explosion()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sprite_animation_finished():
	queue_free()
