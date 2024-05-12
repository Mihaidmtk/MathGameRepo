extends Node2D

var time: float
var is_colided = false
var trail: Trail
var SPEED = 150
var origin_offset := Vector2(Global.border_offset.x, Global.grid_size.y/2 + Global.border_offset.y)



# Called when the node enters the scene tree for the first time.
func _ready():
	time = origin_offset.x
	position = origin_offset
	trail = Trail.create()
	add_child(trail)

func _process(delta : float):
		
	if not is_colided:
		position.x = time
		position.y = sinus(position.x)
		time += delta * SPEED
		
		

func linear(x:float, a:float = 1, b:float = 0) -> float:
	x = (x - origin_offset.x) * 1/Global.cell_size.x 
	return (-a*x -b) * Global.cell_size.y + origin_offset.y
	
func exponential(x:float, a:float = 1, b:float = 0, c:float = 0) -> float:
	x = (x - origin_offset.x) * 1/Global.cell_size.x
	return (-a*pow(x, 2) - b*x - c) * Global.cell_size.y + origin_offset.y
	
func sinus(x:float, a:float = 1, b:float = 0) -> float:
	x = (x - origin_offset.x) * 1/Global.cell_size.x
	return (-a*sin(x) - b) * Global.cell_size.y + origin_offset.y


func _on_area_2d_area_entered(area):
	print("body entered")
	print(area)
	is_colided = true
	if trail: trail.stop()
