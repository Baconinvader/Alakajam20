extends Entity

## Stairs to escape from
class_name Stairs

func interact():
	g.main.reset()
	g.main.add_win_screen()
	
