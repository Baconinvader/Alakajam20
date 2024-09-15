extends Control

class_name WinScreen

func _on_menu_pressed():
	g.main.reset()
	g.main.add_start_screen()
	queue_free()
