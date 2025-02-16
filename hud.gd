extends CanvasLayer
var score = 0

func _ready():
	pass 

func _process(delta):
	pass
	
func asteroid_destroied(ast):
	var pontos = (6 - ast.chosen) * 10
	score += pontos
	$score.text = str(score)

	
	
