extends Node2D
class_name DefendLine
	
static func create() -> DefendLine:
	var scn = preload("res://Scenes/defendline.tscn")
	return scn.instantiate()
