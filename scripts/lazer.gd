extends Node2D

var vel = 200
var PRE_EXPLOSION = preload ("res://scenes/mini_explosion.tscn")

func _ready():
	pass 

func _process(delta):
	translate(Vector2(0, -1)*vel*delta)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()# destroi o lazer para não sobrecarregar de objetos 


func _on_area_area_entered(area):#quando o laser colidir
	var e = PRE_EXPLOSION.instance()#criar uma nova instancia
	get_parent().add_child(e)#vai colocar no nó pai
	e.global_position = global_position#vai posicionar no msm lugar
	queue_free()#depois ele se destroi
