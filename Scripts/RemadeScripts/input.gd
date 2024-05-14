extends HBoxContainer

var FunctionSelector = preload("res://Scenes/RemadeScenes/UI/function_selector.tscn")

func _ready():
	pass
	
func create_function_selectors(func_count : int):
	for selector in get_children():
		selector.queue_free()
	for idx in range(func_count):
		var scn = FunctionSelector.instantiate()
		add_child(scn)
		get_child(idx).name = "funcion_selector_" + str(idx)

func get_function_values() -> Array:
	var data := []
	for child in get_children():
		data.append(child.get_values())
	return data
	
func update_sliders():
	for selector in get_children():
		selector.set_slider_enabled()
		selector.set_slider_range()
