extends Node2D

const PRE_LAZER = preload("res://scenes/lazer.tscn")

export var vel = 100.0 #velocidade da nave
#posição minima esquerda 21
#posição maxima da direita 139
#posição minima em y é 24
#posição maxima em y é 266
export(NodePath) var lazeres

var escudo = 100.0
onready var escudo_size = $escudo/sprite.material.get_shader_param("size")

onready var shape_size = $area/shape.shape.radius


func _ready():
	if lazeres:
		lazeres = get_node(lazeres)
	else:
		lazeres = get_parent()




func _process(delta):
	var dirX = 0
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
	if Input.is_action_pressed("ui_right"):
		dirX += +1
		
	var diry = 0
	if Input.is_action_pressed("ui_up"):
		diry += -1
	if Input.is_action_pressed("ui_down"):
		diry += 1
	
	if Input.is_action_just_pressed("ui_accept"):#para sair o lazer 1x
			if get_tree().get_nodes_in_group("lazeres").size() < 8:
				var lazer= PRE_LAZER.instance()
				lazeres.add_child(lazer)
				lazer.global_position = $blaster.global_position

		
		#acima o jeito correto para usar o tiro da nave#
		
		#jeito abaixo nao é tão usado para o tiro
	#lazer.global_position = global_position + Vector2(0 , -30)#
	#local onde lazer ira surgir comando"ACIMA"...
	
	
	translate(Vector2(dirX, diry) * vel * delta)

	pass
	#if global_position.x<21: esse é um jeito com 
	#   global_position.x=21  muitas linhas
	#if global_position.x>139:  de
	#   global_position.x=139   comando.
	# forma mais correta para limitir a posição máxima da nave"ABAIXO"
	global_position.x = clamp (global_position.x , 21 , 139)
	global_position.y = clamp (global_position.y , 24 , 266)

	
	


func _on_area_area_entered(area):
	if area.get_parent().has_method("destroy"):#verifica se a area tem metodo destroy.
		area.get_parent().destroy()            #se tiver destroy
	
	#print (escudo_size)
	get_tree().call_group("camera" , "treme" , 2  )
	escudo -= 2
	var proporcao = escudo / 100.0 
	$area/shape.shape.radius = shape_size * proporcao
	$escudo/sprite.material.set_shader_param("size" , escudo_size * proporcao)

func _on_dead_area_area_entered(area):
	visible = false
	set_process(false)
