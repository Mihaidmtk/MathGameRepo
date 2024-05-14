extends HBoxContainer
var coeff_name : String
@onready var coefficient_tag = $coefficient_tag
@onready var coefficient_value = $coefficient_value

func _ready():
	pass
func _process(_delta):
	pass

func set_slider(tag:String, value:= 0):
	coeff_name = tag
	coefficient_value.value = value
	coefficient_tag.text = coeff_name + "=" + str(coefficient_value.value)

func set_slider_enabled(val: bool):
	coefficient_value.editable = val

func _on_coefficient_value_value_changed(value):
	coefficient_tag.text = coeff_name + "=" + str(coefficient_value.value)
	
func get_value() -> float:
	return coefficient_value.value
