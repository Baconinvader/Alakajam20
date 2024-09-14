extends Control


func _on_start_pressed():
	g.main.start_game()
	queue_free()
