extends Control

func _ready():
	set_indicator_visible([true, false, false])
func _process(_delta):
	pass
	
func set_indicator_visible(a := [false, false, false]):
	for idx in get_child_count():
		get_child(idx).visible = a[idx]
