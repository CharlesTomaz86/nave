extends Node2D

var chosen = 0

var hp = 0

onready var velY = rand_range( 30 , 50 )
onready var velX = rand_range( -50 , 50 )
var knock_back = 0
signal destroied(node)

#ABAIXO COLOCANDO UMA VIDA NO METEORO
var hps = [
	2 ,
	2 ,
	4 ,
	3 ,
	3 
]
func _ready():#escolha do asteroid entra em cena
	randomize()# deixa os asteroids de forma aleatoria no game
		
	# abaixo o laço for q deixa os asteroids invisiveis
	# incluindo asteroid no game
	for a in $asteroids.get_children():
		a.visible = false
		
		
	if not chosen: #caso nao tenha escolhido
			
			#ABAIXO RANDOMIZA UM DOS 5 ASTEROIDS PARA APARECER#
		chosen = (randi() % $asteroids.get_child_count()) + 1
		
		hp = hps[chosen - 1]
		
	var node = get_node("asteroids/asteroid-" + str(chosen)) 
		
	node.visible = true
		 #abaixo atraves do cód aumentamos o raio de colisao
		 #para o tamanho do meteoro
	$area/shape.shape.radius = node.texture.get_width() / 2
		

func _process(delta):
	translate(Vector2( velX, velY - knock_back ) * delta )
	
	if global_position.x > 200 :
		   global_position.x = - 40
		
	if global_position.x < - 40:
		   global_position.x = 200
		
	if global_position.y > 300 :
	 global_position.y = -60
	
	if knock_back :
		knock_back = lerp(knock_back , 0 , .1)

func _on_area_area_entered(area):
	hp -= 1
	knock_back = 80
	
	
	if hp < 1:
		#queue_free()
		destroy()

	else :
		get_tree().call_group("camera" , "treme" , .5 )
		
		
func destroy():
	get_tree().call_group("camera" , "treme" , 1  )#treme a tela
	emit_signal("destroied" , self) #emite um sinal
	queue_free()    #destroi o asteroid
	
func get_hp_inicial():
	return hps[chosen - 1]
