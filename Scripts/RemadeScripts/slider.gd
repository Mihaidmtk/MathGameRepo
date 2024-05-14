extends HBoxContainer
var coeff_name : String
var change = false
@onready var coefficient_tag = $coefficient_tag
@onready var coefficient_value = $coefficient_value

signal slider_changed

func _ready():
	pass
func _process(_delta):
	if change:
		change = false
		emit_signal("slider_changed")

func set_slider(tag:String, value:= 0):
	coeff_name = tag
	coefficient_value.value = value
	coefficient_tag.text = coeff_name + "=" + str(coefficient_value.value)

func set_slider_enabled(val: bool):
	coefficient_value.editable = val
	
func get_value() -> float:
	return coefficient_value.value
	
func _on_coefficient_value_value_changed(value):
	change = true
	coefficient_tag.text = coeff_name + "=" + str(coefficient_value.value)

func _on_coefficient_value_changed():
	change = true
