extends Switch

var locked:bool = true

func _on_valid_code_entered():
	locked = false
	
func interact():
	super.interact()
	if locked:
		var entity_popup:EntityPopup = load("res://UI/entity_popup.tscn").instantiate()
		var code_entry:CodeEntry = load("res://UI/code_entry.tscn").instantiate()
		code_entry.connect("valid_code_entered", _on_valid_code_entered)
		
		entity_popup.add_child(code_entry)
		g.main.ui_layer.add_child(entity_popup)
	else:
		on = not on
	
