extends Entity

## Simple resettable user of TileRemover
class_name SimpleRemover

@export var width:float = 2.0
@export var height:float = 2.0


@onready var remover = $remover

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$remover.width = width
	$remover.height = height

func do_removal():
	$remover.do_removal()
	
	
func reset_loop():
	super.reset_loop()
	$remover.reset_loop()
	
	

