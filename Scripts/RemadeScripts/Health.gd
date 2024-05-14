extends Control

@onready var heart_1 = $heart_1
@onready var heart_2 = $heart_2
@onready var heart_3 = $heart_3

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func update_health_ui(h :int):
	if h == 0:
		heart_1.visible = false
		heart_2.visible = false
		heart_3.visible = false
	elif h == 1:
		heart_1.visible = true
		heart_2.visible = false
		heart_3.visible = false
	elif h == 2:
		heart_1.visible = true
		heart_2.visible = true
		heart_3.visible = false
	elif h == 3:
		heart_1.visible = true
		heart_2.visible = true
		heart_3.visible = true

