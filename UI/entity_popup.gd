extends PopupPanel

class_name EntityPopup

func _ready():
	g.player.interacting = g.interacting
	g.popup = self
	
func _exit_tree():
	g.player.interacting = null
