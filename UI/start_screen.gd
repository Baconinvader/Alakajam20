extends Control

class_name StartScreen

func _ready():
	$bg_music.play()
	$anim.play()

func _on_start_pressed():
	$bg_music.stop()
	g.main.start_game()
	queue_free()
