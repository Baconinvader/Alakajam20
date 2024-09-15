extends CharacterBody2D

## Base class for all game objects
class_name Entity

## Whether this object should be reset during a loop
@export var do_reset:bool = true

@export var start_collidable:bool = true
@export var start_visible:bool = true
@export var is_static:bool = true
@export_multiline var simple_dialogue:String = ""

var first_interaction:bool = true
var old_dialogue:Array[String] = []
@export var can_repeat_dialogue:bool = false

var frozen_mat:ShaderMaterial = preload("res://assets/frozen_material.tres")

## Permanence mechanic
#@export var can_freeze:bool = true
var frozen:bool = false:set=_set_frozen
func _set_frozen(val:bool):
	frozen = val
	if frozen:
		for child in get_children():
			if child is Sprite2D or child is AnimatedSprite2D:
				child.material = frozen_mat
	else:
		for child in get_children():
			if child is Sprite2D or child is AnimatedSprite2D:
				child.material = null
		

## Whether this object has been "freed" this loop, like queue_free but reversible
var freed_loop:bool = false

## Override this as required, called whenever a loop reset occurs
func reset_loop():
	visible = true
	$shape.disabled = not start_collidable
	freed_loop = false
	
## Called instead of reset_loop if entity is frozen
func reset_loop_frozen():
	pass
	
func _ready():
	if is_static:
		collision_mask = 0b00000000_00000000_00000000_00000000
	else:
		collision_mask = 0b00000000_00000000_00000000_00000001
	
func _physics_process(_delta):
	if not is_static:
		move_and_slide()
	
## Override this as required, use this instead of queue_free
## when you need to remove an object for a single loop
func free_loop():
	visible = false
	$shape.disabled = true
	freed_loop = true
	
## Override this as required, called whenever interaction occurs
func interact():
	if first_interaction:
		first_interaction = false
	
	var dlg = interaction_dialogue()
	if can_repeat_dialogue:
		d.basic_dialogue(dlg)
	else:
		if dlg not in old_dialogue:
			old_dialogue.append(dlg)
			d.basic_dialogue(dlg)
	
## Override this as required, checks if this object can be interacted with
func can_interact() -> bool:
	return true

## Override this as required if differs from can_interact
func can_freeze() -> bool:
	return can_interact()
	
## Overwrite for more complex dialogue
func interaction_dialogue() -> String:
	return simple_dialogue
