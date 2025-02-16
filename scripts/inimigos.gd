extends Node2D
const PRE_ASTEROID = preload("res://scenes/asteroid.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")
const PRE_CRISTAL = preload("res://scenes/cristal.tscn")

export (NodePath) var nave

func _ready():
	restartTimer()
	
func _process(delta):
	pass
	  
func _on_spawn_timer_timeout():
	var ast = created_asteroid()
	add_child(ast)
	ast.global_position = Vector2( rand_range(40 , 120) , -60 )
	restartTimer()
	
func restartTimer():
	$spawn_timer.wait_time = rand_range( .5 , 3 )
	$spawn_timer.start()
	
func on_asteroid_destroied(ast):
	if ast.chosen >= 3:# se o asteroid destruido for grande
		
		for a in range((randi() % 2) + 2 ):# executa 2x= 2 asteroides no lugar do grande q 
			var new_ast = created_asteroid()   ##foi destruido
			new_ast.chosen = (randi() % 2) + 1 #gera meteoro de tamanho 1 ou 2
			add_child(new_ast)
			new_ast.global_position = ast.global_position
			
	get_tree().call_group("hud" , "asteroid_destroied" , ast) # sinaliza que um 
															  # asteroid foi destruido
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = ast.global_position##aqui diz que a explosao        ##
										   ## fica no msm lugar do asteroid ##
	for a in range(ast.get_hp_inicial()):
		var c = PRE_CRISTAL.instance()
		add_child(c)
		c.global_position = ast.global_position
func created_asteroid ():
		var ast = PRE_ASTEROID.instance()
		ast.connect("destroied" , self , "on_asteroid_destroied")
		return ast
	
										
