extends Node2D

@onready var player_1 = $player1
@onready var player_2 = $player2
@onready var ui = $ui_layer/UI

var p1_functions : Array
var p2_functions : Array

var p1_sim_functions : Array
var p2_sim_functions : Array

func _ready():
	ui.input.create_function_selectors(Global.functions_count[0])
	player_1.position = Vector2(50, Global.cell_count.y/2 * Global.cell_size.y)
	player_2.position = Vector2(Global.cell_count.x * Global.cell_size.y - 50, Global.cell_count.y/2 * Global.cell_size.y)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.turn % 2 == 0:
		#create p1 / p2 sim functions spawners
		#for function in player1.sim_spawners():
		#	function.update_function(x, Create_Function(type, (a,b,c))
		pass
		
	else:
		pass
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
	if posmod(Global.turn, 4) == 1: #finished p1 turn
		p1_functions = ui.input.get_function_values()
		print("p1 func:" + str(p1_functions))
	if posmod(Global.turn, 4) == 3: #finished p2 turn
		p2_functions = ui.input.get_function_values()
		print("p2 func:" + str(p2_functions))
	#update turn
	if Global.turn > 2:
		Global.turn += 1
	else: Global.turn += 2

	#Setup next turn
	#Sim Turn
	if Global.turn % 2 == 0:
		ui.arrow.set_indicator_visible([false, false, true])
		if Global.turn % 4 == 0: #Sim Turn p1
			p1_sim_functions = p1_functions
			p2_sim_functions = p2_functions
			
	#Player Turn
	else:					 
		if Global.turn % 4 == 1:
			ui.arrow.set_indicator_visible([true, false, false])
			ui.input.create_function_selectors(Global.functions_count[0])
		elif Global.turn % 4 == 3:
			ui.arrow.set_indicator_visible([false, true, false])
			ui.input.create_function_selectors(Global.functions_count[1])


