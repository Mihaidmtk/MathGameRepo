extends Line2D

var type:=0
var max_points = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = false
	pass
func _process(delta):
	pass

func update_trajectory(type:int ,coeff:Vector3):
	if type == 0 or Global.turn % 2 == 0: clear_points()
	else:
		clear_points()
		var pos
		for i in max_points:
			if Global.turn % 4 == 1:
				pos = Vector2(i, Global.Function(i, type, coeff))
			elif Global.turn % 4 == 3:
				pos = Vector2(-i, Global.Function(i, type, coeff))
			add_point(pos)
