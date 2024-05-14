extends Node

var functions_dict := {
 0 : "alege functia",
 1 : "ax + b",
 2 : "ax^2 + bx + c",
 3 : "a*sqrt(x) + b",
 4 : "a*sin(x) + b",
 5 : "a*cos(x) + b",
 6 : "ax, x:(b, c)"}
var slider_dict := {
	0 : [0, 0, 0],
	1 : [1, 1, 0],
	2 : [1, 1, 1],
	3 : [1, 1, 0],
	4 : [1, 1, 0],
	5 : [1, 1, 0],
	6 : [1, 1, 1]}
var unlocked := [1,1,1,1,1,0,0]

var cell_size := Vector2(50, 50)
var cell_count := Vector2(20, 20)

var background_color := Color("052A59")
var grid_color := Color("D93B92")
var grid_color_accent := Color("#F2A0A0")
var grid_color_div := Color("#F2388F")
var border_color := Color("#8C2B86")

var p1_functions : Array
var p2_functions : Array

func get_linear(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	return -(coeff.x * xo + coeff.y)*1/cell_size.y
	
func get_exponential(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	return -(coeff.x * pow(xo, 2) + coeff.y * xo + coeff.z)*1/cell_size.y
	
func get_sqrt(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	return -(coeff.x * sqrt(xo) + coeff.y)*1/cell_size.y
	
func get_sin(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	return -(coeff.x * sin(xo) + coeff.y)*1/cell_size.y
	
func get_cos(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	return -(coeff.x * cos(xo) + coeff.y)*1/cell_size.y
	
func get_variable(x: float, coeff := Vector3(0,0,0)) -> float:
	var xo = x * 1/cell_size.x
	var aux_b = coeff.y
	var aux_c = coeff.z
	if coeff.y > coeff.z:
		aux_b = coeff.z
		aux_c = coeff.y
	return -(coeff.x * xo + coeff.y)*1/cell_size.y
