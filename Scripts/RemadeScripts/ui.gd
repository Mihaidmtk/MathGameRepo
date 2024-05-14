extends Control
@onready var health = $game_state/Health
@onready var arrow = $game_state/turns/Arrow
@onready var input = $input

func _ready():
	pass # Replace with function body.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Global.p1_functions = input.get_function_values()
		print(Global.p1_functions)
	pass

