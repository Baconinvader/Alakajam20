extends Control

class_name CodeEntry

@export var correct_code:String = "123"
var valid:bool = false

signal valid_code_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_pressed():
	var code:String = $entrybox.text
	$entrybox.text = ""
	
	if code == correct_code:
		valid = true
		$entrybox.editable = false
	else:
		valid = false

func _on_exit_pressed():
	if g.popup:
		g.popup.queue_free()
	queue_free()
