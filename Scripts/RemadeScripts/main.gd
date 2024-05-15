extends Node2D

@onready var player_1 = $player1
@onready var player_2 = $player2
@onready var ui = $ui_layer/UI
@onready var trajectories = $trajectories

var trj_functions : Array

var p1_sim_functions : Array
var p2_sim_functions : Array

func _ready():
	ui.input.create_function_selectors(Global.functions_count[0])
	trajectories.create_trajectories()
	player_1.position = Vector2(50, Global.cell_count.y/2 * Global.cell_size.y)
	player_2.position = Vector2(Global.cell_count.x * Global.cell_size.y - 50, Global.cell_count.y/2 * Global.cell_size.y)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(trj_functions)
	if Global.turn % 2 == 0:
		pass
	else:
		trj_functions = ui.input.get_function_values()
		print("aaaaaa")
		for idx in trajectories.get_child_count():
			trajectories.get_child(idx).update_trajectory(trj_functions[idx][0], trj_functions[idx][2])

func _draw():
	draw_rect(Rect2(0, 0, Global.cell_count.x*Global.cell_size.x + 200, Global.cell_count.y*Global.cell_size.y + 200), Global.background_color)
	for line in range(0, Global.cell_count.x + 1):
		var width = 2
		var color = Global.grid_color
		if line == 0 or line == Global.cell_count.x:
			width = 10
			color = Global.border_color
		elif line == Global.cell_count.x/2:
			width = 4
			color = Global.grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = Global.grid_color_div
		draw_line(Vector2(Global.cell_size.x * line, 5), Vector2(Global.cell_size.x * line, Global.cell_count.y * Global.cell_size.y - 5),color, width)	
	for line in range(0, Global.cell_count.y + 1):
		var width = 2
		var color = Global.grid_color
		if line == 0 or line == Global.cell_count.y:
			width = 10
			color = Global.border_color
		elif line == Global.cell_count.y/2:
			width = 4
			color = Global.grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = Global.grid_color_div
		draw_line(Vector2(5, Global.cell_size.y * line), Vector2(Global.cell_count.x * Global.cell_size.x - 5, Global.cell_size.y * line),color, width)

func _on_end_turn_button_up():
	#finish turn
	if Global.turn % 4 == 1: #finished p1 turn
		p1_sim_functions = trj_functions
	elif Global.turn % 4 == 3: #finished p2 turn
		p2_sim_functions = trj_functions
	#update turn
	if Global.turn > 2:
		Global.turn += 1
	else: Global.turn += 2

	#Setup next turn
	#Sim Turn
	if Global.turn % 2 == 0:
		ui.arrow.set_indicator_visible([false, false, true])
		if Global.turn % 4 == 0: #Sim Turn p1
			pass
	#Player Turn
	else:
		trajectories.create_trajectories() 
		if Global.turn % 4 == 1:
			ui.arrow.set_indicator_visible([true, false, false])
			ui.input.create_function_selectors(Global.functions_count[0])
		elif Global.turn % 4 == 3:
			ui.arrow.set_indicator_visible([false, true, false])
			ui.input.create_function_selectors(Global.functions_count[1])


