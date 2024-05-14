extends Line2D

var type:=0
var max_points = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_trajectory(type : int, coeff :Vector3):
	if type == 0 or Global.turn % 2 == 0: clear_points()
	else:
		clear_points()
		if Global.turn % 4 == 1:
			get_parent().position = Vector2(Global.cell_size.x * 5, Global.cell_count.y/2 * Global.cell_size.y)
			var pos = Vector2(0,0)
			for i in max_points:
				add_point(pos)
				pos = Vector2(i, Global.Function(i, type, coeff))
		elif Global.turn % 4 == 3:
			get_parent().position = Vector2((Global.cell_count.x - 5) * Global.cell_size.x, Global.cell_count.y/2 * Global.cell_size.y)
			var pos = Vector2(0,0)
			for i in max_points:
				add_point(pos)
				pos = Vector2(-i, Global.Function(i, type, coeff))
	pass
