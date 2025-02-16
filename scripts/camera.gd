extends Camera2D

var time = 0
var forca = 0
func _ready():
	pass 



func _process(delta): # func para a camera da nave tremer#
	if forca > 0:
		time += delta * 100
		global_position = Vector2( forca , forca ).rotated(time)
		forca = lerp(forca , 0 , .1) # vai diminuir o tremer até 0.
	
#	if Input.is_action_just_pressed("ui_cancel"): #comando para camera tremer 
#		treme(1)   
	
func treme(v):
	forca += v

