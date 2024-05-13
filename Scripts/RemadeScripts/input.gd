extends HBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	update_function_selectors(4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_function_selectors(func_count : int):
	for child in get_children():
		child.queue_free()
	for idx in range(func_count):
		var scn := FunctionSelector.create()
		add_child(scn)
		get_child(idx).name = "funcion_selector_" + str(idx)

func get_function_values() -> Array:
	var data : Array
	for child in get_children():
		data.append(child.get_values())
	return data
