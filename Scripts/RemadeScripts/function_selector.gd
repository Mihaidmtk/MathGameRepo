extends VBoxContainer
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



