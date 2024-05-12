extends HBoxContainer

@onready var a = $a
@onready var a_slider = $a_slider
@onready var b = $b
@onready var b_slider = $b_slider
@onready var c = $c
@onready var c_slider = $c_slider
# Called when the node enters the scene tree for the first time.
func _ready():
	a_slider.value = 1
	b_slider.value = 0
	c_slider.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	a.text = "a=" + str(a_slider.value)
	b.text = "b=" + str(b_slider.value)
	c.text = "c=" + str(c_slider.value)
