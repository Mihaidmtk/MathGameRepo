extends Node2D

@onready var player_1 = $player1
@onready var player_2 = $player2
@onready var ui = $ui_layer/Control/UI
@onready var trajectories = $trajectories
@onready var camera = $Camera2D
@onready var end_turn = $ui_layer/Control/UI/EndTurn
@onready var ui_layer = $ui_layer

var func_spawner := preload("res://Scenes/RemadeScenes/GameLogic/function_spawner.tscn")

var p1_sim_functions : Array
var p2_sim_functions : Array

var sim_time : float
var SIM_SPEED = 200
func _ready():
	ui_layer.visible=true
	trajectories.create_trajectories()
	ui.health.update_health_ui(Global.health[0])
	camera.position = Vector2(camera.camera_limit_left, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
	ui.arrow.set_indicator_visible([true, false, false])
	ui.input.create_function_selectors(Global.functions_count[0])
	$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	
	player_1.position = Vector2(50, Global.cell_count.y/2 * Global.cell_size.y)
	player_2.position = Vector2(Global.cell_count.x * Global.cell_size.y - 50, Global.cell_count.y/2 * Global.cell_size.y)

func _process(delta):
	sim_time += delta * SIM_SPEED
	if Global.turn % 3 == 1 or Global.turn % 3 == 2: #p1/p2turn
		trajectories.update_trajectories(ui.input.get_function_values())
	elif Global.turn % 3 == 0: #p1 sim
		if !player_1.is_all_collided() or !player_2.is_all_collided():
			for f in player_1.sim_spawners.get_children():
				if f is FunctionSpawner and f.type != 0:
					f.update_function(sim_time)
			for f in player_2.sim_spawners.get_children():
				if f is FunctionSpawner and f.type != 0:
					f.update_function(sim_time)
		else: 
			end_turn.disabled = false
			ui_layer.visible=true
		
func _draw():
	draw_rect(Rect2(-1000, -1000, Global.cell_count.x*Global.cell_size.x + 2000, Global.cell_count.y*Global.cell_size.y + 2000), Global.background_color)
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
	Global.turn += 1
	
	if Global.turn % 3 == 1:
		trajectories.create_trajectories()
		ui.health.update_health_ui(Global.health[0])
		camera.zoom = Vector2(1,1)
		camera.position = Vector2(camera.camera_limit_left, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
		ui.arrow.set_indicator_visible([true, false, false])
		ui.input.create_function_selectors(Global.functions_count[0])
		$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	elif Global.turn % 3 == 2:
		trajectories.create_trajectories()
		p1_sim_functions = ui.input.get_function_values()
		ui.health.update_health_ui(Global.health[1])
		camera.position = Vector2(camera.camera_limit_right, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
		ui.arrow.set_indicator_visible([false, true, false])
		ui.input.create_function_selectors(Global.functions_count[1])
		$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	else:
		camera.zoom = Vector2(0.4, 0.4)
		camera.position = Vector2(Global.cell_count*Global.cell_size/2)
		ui_layer.visible=false
		trajectories.clear_trajectories()
		p2_sim_functions = ui.input.get_function_values()
		for idx in Global.functions_count[1]:
			var f := func_spawner.instantiate()
			player_2.sim_spawners.add_child(f)
			player_2.sim_spawners.get_child(idx).set_function(2, p2_sim_functions[idx][0], p2_sim_functions[idx][1], p2_sim_functions[idx][2])
		for idx in Global.functions_count[0]:
			var f := func_spawner.instantiate()
			player_1.sim_spawners.add_child(f)
			player_1.sim_spawners.get_child(idx).set_function(1, p1_sim_functions[idx][0], p1_sim_functions[idx][1], p1_sim_functions[idx][2])
		
		sim_time = 0
		ui.input.clear_selectors()
		end_turn.disabled = true
		$ui_layer/Control/UI/EndTurn/Turn.text = "Încheie Tura"
		pass


