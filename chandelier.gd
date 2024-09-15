extends Node2D

var falling: bool = false
var fall_rate: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling == true:
		var m_body = $main 
		var shadow = $shadow
		m_body.position.y  -= fall_rate 
		if m_body.position.y - shadow.position.y < 10:
			falling = false 
			explode()
	pass


func fall():
	falling = true 
	pass 
	
func explode():
	#if $Area2D
	pass
	
