extends Switch

## Used to control steam, har har

class_name Valve

@export var steam_controllers:Array[SteamController] = []

func reset_loop():
	super.reset_loop()
	set_controllers(false)
	
## Turn the steam on or off
func set_controllers(val:bool):
	for controller:SteamController in steam_controllers:
		controller.active = val

func interact():
	super.interact()
	set_controllers(on)
