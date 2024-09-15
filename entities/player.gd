extends Creature

## Player
class_name Player

## Area used to check if the player is in range of an object to interact with
@onready var interaction_area = $interaction_area

## Whatever we are currently interacting with
var interacting

## Item we are currently holding
var item:Item = null:set=_set_item
func _set_item(val:Item):
	item = val
	if item:
		$item_sprite.visible = true
		$item_sprite.texture = item.tex
	else:
		$item_sprite.visible = false

func _physics_process(_delta):
	super._physics_process(_delta)
	if interacting or dying:
		move_dir = Vector2.ZERO
		return
	
	move_dir = Vector2(0.0,0.0)
	if Input.is_action_pressed("move_up"):
		move_dir += Vector2(0.0,-1.0)
	if Input.is_action_pressed("move_down"):
		move_dir += Vector2(0.0,1.0)
	if Input.is_action_pressed("move_left"):
		move_dir += Vector2(-1.0,0.0)
	if Input.is_action_pressed("move_right"):
		move_dir += Vector2(1.0,0.0)
	move_dir = move_dir.normalized()
	
## Returns the first area the player can interact with, or null is there isn't one
func get_first_interactable() -> InteractArea:
	var can_interact_with_anything:InteractArea = null
	var interactables:Array = get_tree().get_nodes_in_group("interact")
	for interact_area:InteractArea in interactables:
		if interact_area.player_can_interact:
			can_interact_with_anything = interact_area
			return can_interact_with_anything
	return can_interact_with_anything
		
func get_first_freezable() -> InteractArea:
	var can_interact_with_anything:InteractArea = null
	var interactables:Array = get_tree().get_nodes_in_group("interact")
	for interact_area:InteractArea in interactables:
		if interact_area.player_can_freeze:
			can_interact_with_anything = interact_area
			return can_interact_with_anything
	return can_interact_with_anything
		
				
		
func _input(ev:InputEvent):
	if interacting:
		return
	
	if ev.is_action_pressed("reset"):
		g.main.reset_loop()
	elif ev.is_action_pressed("interact"):
		var can_interact_with_anything:InteractArea = get_first_interactable()
		
		if can_interact_with_anything:
			can_interact_with_anything.interact()
		else:
			if item:
				drop_item()
	elif ev.is_action_pressed("freeze"):
		var interact_area:InteractArea = get_first_freezable()
		if interact_area:
			var interact_obj:Entity = interact_area.obj
			if interact_obj and interact_obj.can_freeze:
				interact_obj.frozen = not interact_obj.frozen
	
func reset_loop():
	super.reset_loop()
	item = null
	position = g.level.player_spawn.position
	
## Drop currently held item
func drop_item():
	if item:
		var item_entity:ItemEntity = load("res://entities/item_entity.tscn").instantiate()
		item_entity.item = item
		item_entity.position = position
		#item_entity.velocity = velocity
		item_entity.original = false
		g.level.entities.add_child(item_entity)
		item = null

func die():
	super.die()
	g.main.reset_loop()
	
