extends VBoxContainer
class_name FunctionSelector
@onready var slider_a = $slider_a
@onready var slider_b = $slider_b
@onready var slider_c = $slider_c
@onready var type = $type
@onready var mode = $mode


# Called when the node enters the scene tree for the first time.
func _ready():
	slider_a.set_slider("a", 0)
	slider_b.set_slider("b", 0)
	slider_c.set_slider("c", 0)
	
	mode.add_item("atac")
	mode.add_item("apărare")
	mode.add_item("recunoaștere")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
static func create() -> FunctionSelector:
	var scn = preload("res://Scenes/RemadeScenes/UI/function_selector.tscn")
	return scn.instantiate()
	
func get_values() -> Array:
	var data : Array = [type.selected, mode.selected, Vector3(slider_a.value, slider_b.value, slider_c.value)]
	return data



