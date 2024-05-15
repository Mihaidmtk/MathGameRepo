extends Line2D

var max_points = Global.cell_size.x * 4
# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = false
	pass
func _process(_delta):
	pass

func update_trajectory(type:int ,coeff:Vector3):
	if type == 0: clear_points()
	else:
		clear_points()
		var pos
		for i in max_points:
			if Global.turn % 3 == 1:
				pos = Vector2(i, Global.Function(i, type, coeff))
			elif Global.turn % 3 == 2:
				pos = Vector2(-i, Global.Function(i, type, coeff))
			add_point(pos)
