extends Node2D
export (NodePath) var nave

func _ready():
	if nave:
		nave = get_node(nave)
	else:           

		set_process(false)
		
func _process(delta):

	  global_position.x = (nave.global_position.x - 80) * 0.002 * -160 


