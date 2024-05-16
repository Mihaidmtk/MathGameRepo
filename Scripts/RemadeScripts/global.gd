extends Node

var functions_dict := {
 0 : "alege functia",
 1 : "ax + b",
 2 : "ax^2 + bx + c",
 3 : "a*sqrt(x) + b",
 4 : "a*sin(x) + b",
 5 : "a*cos(x) + b",}
var slider_dict := {
	0 : [0, 0, 0],
	1 : [1, 1, 0],
	2 : [1, 1, 1],
	3 : [1, 1, 0],
	4 : [1, 1, 0],
	5 : [1, 1, 0],
}
	
var unlocked := [[1,1,0,0,0,0],[1,1,0,0,0,0]]

var slider_ranges := {
	1:[[-2,2],[-14,14],[0,0]],
	2:[[-1,1], [-5,5], [-14,14]],
	3:[[-4,4], [-14,14],[0,0]],
	4:[[-5,5], [-14,14],[0,0]],
	5:[[-5,5], [-14,14],[0,0]],
}

var cell_size := Vector2(80, 80)
var cell_count := Vector2(60, 30)

var background_color := Color("052A59")
var grid_color := Color("D93B92")
var grid_color_accent := Color("#F2A0A0")
var grid_color_div := Color("#F2388F")
var border_color := Color("#8C2B86")
var p1_color := Color("#04F570")
var p2_color := Color("#04F570")

var health := [3, 3]
var functions_count := [3, 2]
var max_func_count := 5
var turn := 1

func get_linear(x: float, coeff := Vector3(0,0,0)) -> float:
	return -(coeff.x * x + coeff.y)
	
func get_exponential(x: float, coeff := Vector3(0,0,0)) -> float:
	return -(coeff.x * pow(x, 2) + coeff.y * x + coeff.z)
	
func get_sqrt(x: float, coeff := Vector3(0,0,0)) -> float:
	return -(coeff.x * sqrt(x) + coeff.y)
	
func get_sin(x: float, coeff := Vector3(0,0,0)) -> float:
	return -(coeff.x * sin(x) + coeff.y)
	
func get_cos(x: float, coeff := Vector3(0,0,0)) -> float:
	return -(coeff.x * cos(x) + coeff.y)
	
func get_log(x: float, coeff := Vector3(0,0,0)) -> float:
	return -coeff.y*(log(x)/log(coeff.x))

func Function(x:float, type:int, coeff:Vector3) -> float:
	var xo = x * 1/cell_size.x
	if type == 1: return get_linear(xo, coeff) * cell_size.y
	elif type == 2: return get_exponential(xo, coeff) * cell_size.y
	elif type == 3: return get_sqrt(xo, coeff) * cell_size.y
	elif type == 4: return get_sin(xo, coeff) * cell_size.y
	elif type == 5: return get_cos(xo, coeff) * cell_size.y
	elif type == 6: return get_log(xo, coeff) * cell_size.y
	else: return 0
