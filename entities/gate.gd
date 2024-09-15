extends Entity

## Gate that can be opened via a switch or other means maybe

class_name Gate

@export var switch:Switch = null
@export var anti_switch:Switch = null
@export var key_lock:KeyLock = null

@export var start_raised:bool = false
var raised:bool = false

#@export var lock:KeyLock = null

func _ready():
	super._ready()
	if switch:
		switch.connect("on_changed", _on_switch_on_changed)
	if anti_switch:
		anti_switch.connect("on_changed", _on_anti_switch_on_changed)
		
	if key_lock:
		key_lock.connect("on_unlocked", _on_key_lock_unlocked)
		
	if start_raised:
		raise()

func _on_key_lock_unlocked():
	raise()

func _on_switch_on_changed():
	if switch.on:
		raise()
	else:
		lower()
		
func _on_anti_switch_on_changed():
	if anti_switch.on:
		lower()
	else:
		raise()

func reset_loop():
	super.reset_loop()
	if start_raised != raised:
		if start_raised:
			raise()
		else:
			lower()
		
	if switch:
		_on_switch_on_changed()
		
## Raise the gate
func raise():
	$static_sprite.visible = false
	#visible = false
	$shape.disabled = true
	raised = true
	
## Lower the gate():
func lower():
	$static_sprite.visible = true
	#visible = true
	$shape.disabled = false
	raised = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#func can_interact():
#	return super.can_interact()
	#if not raised:
	#	return true
	#else:
#		return false
	
func can_interact():
	if not raised:
		if not key_lock:
			return true
		else:
			if not key_lock.can_interact():
				return true
	return false
	
func can_freeze():
	return false
