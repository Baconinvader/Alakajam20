extends Node2D

class_name Cloud

@export var min_lifetime:float = 4.0
@export var max_lifetime:float = 8.0

var vel:Vector2
@export var min_vel:float = 5.0
@export var max_vel:float = 15.0


# Called when the node enters the scene tree for the first time.
func _ready():
	vel = Vector2.from_angle(randf_range(0, 2*PI)) * randf_range(min_vel, max_vel)
	
	
	var lifetime:float = randf_range(min_lifetime, max_lifetime)
	
	var t:Tween = create_tween()
	
	modulate.a = 0.0
	
	t.tween_interval(lifetime*0.5)
	t.tween_property(self, "modulate:a", 1.0, lifetime*0.5)
	t.set_parallel(false)
	t.tween_interval(lifetime*0.5)
	t.set_parallel(true)
	t.tween_property(self, "modulate:a", 0.0, lifetime*0.5)
	t.tween_property(self, "vel", Vector2.ZERO, lifetime*0.5)
	
	t.set_parallel(false)
	t.tween_callback(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += vel*delta
	
func _exit_tree():
	pass
	
