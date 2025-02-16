extends Sprite
#var des = 0
export (NodePath) var nave
#onready var nave = get_node("../ship")
var time = 0.0

func _ready():
	if nave:         #se tiver a nave pode usar
		nave = get_node(nave)
	else:           
		 #caso nao tenha nave desligue o processamento
		set_process(false)
		


func _process(delta):
	time += delta * 2# aqui vc pode multiplicar por algum numero
				  # para aumentar ou diminuir a velocidade.
	material.set_shader_param("des" , ( nave.global_position.x - 80) * 0.002 )
	material.set_shader_param("time" , time )

