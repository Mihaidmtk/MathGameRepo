extends Node2D

@onready var player_1 = $player1
@onready var player_2 = $player2
@onready var ui = $ui_layer/Control/UI
@onready var trajectories = $trajectories
@onready var camera = $Camera2D
@onready var end_turn = $ui_layer/Control/UI/EndTurn
@onready var ui_layer = $ui_layer
@onready var obstacle_layer = $obstacle_layer
@onready var exit = $exit
@onready var player_1_turn = $player1turn
@onready var player_2_turn = $player2turn
@onready var winner = $winner
@onready var return_timer = $return


var func_spawner := preload("res://Scenes/RemadeScenes/GameLogic/function_spawner.tscn")

var p1_sim_functions : Array
var p2_sim_functions : Array

var sim_time : float
var SIM_SPEED = 200
func _ready():
	
	winner.visible = false
	player_1_turn.visible = false
	player_2_turn.visible = false
	
	ui_layer.visible=true
	$fow_layer/fow1.visible = true
	$fow_layer/fow2.visible = false
	trajectories.create_trajectories()
	ui.health.update_health_ui(Global.health[0])
	camera.position = Vector2(camera.camera_limit_left, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
	ui.arrow.set_indicator_visible([true, false, false])
	ui.input.create_function_selectors(Global.functions_count[0])
	$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	
	player_1.position = Vector2(50, Global.cell_count.y/2 * Global.cell_size.y)
	player_2.position = Vector2(Global.cell_count.x * Global.cell_size.y - 50, Global.cell_count.y/2 * Global.cell_size.y)
	obstacle_layer.generate_field()
	
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		exit.visible = true
	if Global.health[0] > 0 and Global.health[1] > 0:
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
	else:
		return_timer.start()
		winner.visible = true
		if Global.health[0] <= 0:
			winner.text = "Jucătorul 2 a câștigat"
		else:
			winner.text = "Jucătorul 2 a câștigat"
		
		
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
		player_1_turn.visible = true
		obstacle_layer.clear_field()
		obstacle_layer.generate_field()
		
		player_1.clear_sim_function()
		player_2.clear_sim_function()
		
		$fow_layer/fow1.visible = true 
		$fow_layer/fow2.visible = false
		
		trajectories.create_trajectories()
		ui.arrow.set_indicator_visible([true, false, false])
		ui.input.create_function_selectors(Global.functions_count[0])
		
		ui.health.update_health_ui(Global.health[0])
		
		camera.zoom = Vector2(1,1)
		camera.position = Vector2(camera.camera_limit_left, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
		camera.disable_movement = false
		
		$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	elif Global.turn % 3 == 2:
		player_2_turn.visible = true
		$fow_layer/fow1.visible = false
		$fow_layer/fow2.visible = true
		
		p1_sim_functions = ui.input.get_function_values()
		
		trajectories.create_trajectories()
		ui.health.update_health_ui(Global.health[1])
		ui.arrow.set_indicator_visible([false, true, false])
		ui.input.create_function_selectors(Global.functions_count[1])
		
		
		camera.position = Vector2(camera.camera_limit_right, (camera.camera_limit_top + camera.camera_limit_bottom)/2)
		
		$ui_layer/Control/UI/EndTurn/Turn.text = "Confirmă Alegeri"
	else:
		$fow_layer/fow1.visible = false
		$fow_layer/fow2.visible = false
		
		camera.zoom = Vector2(0.4, 0.4)
		camera.position = Vector2(Global.cell_count*Global.cell_size/2)
		camera.disable_movement = true
		
		p2_sim_functions = ui.input.get_function_values()
		
		
		trajectories.clear_trajectories()
		ui_layer.visible=false
		ui.arrow.set_indicator_visible([false, false, true])
		ui.input.clear_selectors()
		
		
		for idx in Global.functions_count[1]:
			var f := func_spawner.instantiate()
			player_2.sim_spawners.add_child(f)
			player_2.sim_spawners.get_child(idx).set_function(2, p2_sim_functions[idx][0], p2_sim_functions[idx][1], p2_sim_functions[idx][2])
		for idx in Global.functions_count[0]:
			var f := func_spawner.instantiate()
			player_1.sim_spawners.add_child(f)
			player_1.sim_spawners.get_child(idx).set_function(1, p1_sim_functions[idx][0], p1_sim_functions[idx][1], p1_sim_functions[idx][2])
		
		sim_time = 0
		end_turn.disabled = true
		
		$ui_layer/Control/UI/EndTurn/Turn.text = "Încheie Tura"
		pass




func _on_p_2_turn_pressed():
	player_2_turn.visible = false


func _on_p_1_turn_pressed():
	player_1_turn.visible = false


func _on_da_pressed():
	get_tree().change_scene_to_file("res://Scenes/RemadeScenes/UI/menu.tscn")


func _on_return_timeout():
	get_tree().reload_current_scene()


func _on_nu_pressed():
	exit.visible = false
