extends Control

class_name StartScreen

func _on_start_pressed():
	g.main.start_game()
	queue_free()
