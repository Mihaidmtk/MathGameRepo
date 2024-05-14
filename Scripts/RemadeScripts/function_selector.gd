extends VBoxContainer
class_name FunctionSelector
@onready var slider_a = $slider_a
@onready var slider_b = $slider_b
@onready var slider_c = $slider_c
@onready var type = $type
@onready var mode = $mode


# Called when the node enters the scene tree for the first time.
func _ready():
	set_function_types()
	set_slider_enabled()
	
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
	var data : Array = [type.selected, mode.selected, Vector3(slider_a.get_value(), slider_b.get_value(), slider_c.get_value())]
	return data
	
func set_function_types():
	for idx in Global.functions_dict.size():
		type.add_item(Global.functions_dict[idx], idx)
		type.set_item_disabled(idx, !Global.unlocked[idx])
	
func set_slider_enabled():
	slider_a.set_slider_enabled(Global.slider_dict[type.selected][0])
	slider_b.set_slider_enabled(Global.slider_dict[type.selected][1])
	slider_c.set_slider_enabled(Global.slider_dict[type.selected][2])
	
func set_slider_range():
	pass


func _on_type_item_selected(_index):
	set_slider_enabled()
