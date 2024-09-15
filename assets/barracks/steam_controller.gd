extends Node2D

# Controls the release of deadly steam
class_name SteamController

@export var max_clouds:int = 20

@export var active:bool = true:set=_set_active
func _set_active(val:bool):
	active = val
	if active:
		$kill_area.enabled = true
		add_clouds()
	else:
		$kill_area.enabled = false

@export var kill_radius:float = 128.0
@export var spawn_radius:float = 96.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$kill_area/shape.shape.radius = kill_radius

## Add a maximum amount of clouds
func add_clouds():
	var diff = max_clouds - $clouds.get_child_count()
	for i in diff:
		add_cloud()

func add_cloud():
	var cloud:Cloud = load("res://entities/barracks/cloud.tscn").instantiate()
	cloud.position = Vector2.from_angle(randf_range(0, 2*PI)) * randf_range(0.0, spawn_radius) 
	$clouds.add_child(cloud)
	cloud.connect("tree_exited", _on_cloud_exited)
	
func _on_cloud_exited():
	if active:
		add_cloud()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
