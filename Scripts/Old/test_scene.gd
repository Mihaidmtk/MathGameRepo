extends Node2D

#var attack_data_p1 : Array = [0, 0, 0, 0]
#var attack_data_p2 : Array = [0, 0, 0, 0]
#var defend_data_p1 : Array = [0, 0, 0, 0]
#var defend_data_p2 : Array = [0, 0, 0, 0]

@onready var attack_spawn_p1 = $attack_spawn_p1
@onready var attack_spawn_p2 = $attack_spawn_p2

@onready var defend_spawn_p1 = $defend_spawn_p1
@onready var defend_spawn_p2 = $defend_spawn_p2

@onready var attack_slider_container = $UI/FuncSelection/attack_func/attack_slider_container
@onready var defend_slider_container = $UI/FuncSelection/defend_func/defend_slider_container

@onready var attack_select = $UI/FuncSelection/attack_func/attack_select
@onready var defend_select = $UI/FuncSelection/defend_func/defend_select

@onready var ui = $UI

var cell_size := Vector2(25, 25)
var cell_amount := Vector2(40,20)
var grid_size := Vector2(1000, 500)
var border_offset := Vector2(10,10)

var SPEED : float = 100
var DEF_RANGE = 2

var p1_attack : AttackLine
var p2_attack : AttackLine
var p1_defend : DefendLine
var p2_defend : DefendLine

var turn : int = 1

var data : Array = [[[0, 0, 0], [0, 0, 0]],
					[[0, 0, 0], [0, 0, 0]]]
					
var available_func : Array = [[1, 1, 1, 0, 0, 0, 0, 0], [1, 1, 1, 0, 0, 0, 0, 0]]


func _ready(): #line spawns and slider values
	#setup line spawns for p1
	attack_spawn_p1.modulate = Color.RED
	attack_spawn_p2.modulate = Color.RED
	defend_spawn_p1.modulate = Color.REBECCA_PURPLE
	defend_spawn_p2.modulate = Color.REBECCA_PURPLE
	
	attack_spawn_p1.position.x = border_offset.x + 2*cell_size.x
	defend_spawn_p1.position.x = attack_spawn_p1.position.x
	
	attack_spawn_p2.position.x = border_offset.x + 18*cell_size.x 
	defend_spawn_p2.position.x = attack_spawn_p2.position.x
	
	#setup slider values
	attack_slider_container.a_slider.value = 1
	attack_slider_container.b_slider.value = 0
	attack_slider_container.c_slider.value = 1
	
	defend_slider_container.a_slider.value = 1
	defend_slider_container.b_slider.value = 0
	defend_slider_container.c_slider.value = -1
	
	
	
func _process(delta): #main loop
	if turn == 0:
		disable_ui()
		#create attacking/defending functions
		if !p1_attack && !Global.p1_is_collided:
			p1_attack = AttackLine.create()
			p1_attack.player = 1
			attack_spawn_p1.add_child(p1_attack)
		if !p2_attack && !Global.p2_is_collided: 
			p2_attack = AttackLine.create()
			p2_attack.player = 2
			attack_spawn_p2.add_child(p2_attack)
		if !p1_defend:
			p1_defend = DefendLine.create()
			defend_spawn_p1.add_child(p1_defend)
		if !p2_defend:
			p2_defend = DefendLine.create()
			defend_spawn_p2.add_child(p2_defend)
		
		if Global.p1_is_collided && Global.p2_is_collided:
			p1_defend.queue_free()
			p2_defend.queue_free()
			enable_ui()
			turn = 1
		
		
		#move attacking/defending funtions
		if !Global.p1_is_collided:
			p1_attack.position.x += delta * SPEED
			p1_attack.position.y = CreateFunction(p1_attack.position.x, data[0][0][0], data[0][0][1], data[0][0][2])
		if !Global.p2_is_collided:
			p2_attack.position.x -= delta * SPEED
			p2_attack.position.y = CreateFunction(-p2_attack.position.x, data[0][1][0], data[0][1][1], data[0][1][2])
		if p1_defend.position.x < DEF_RANGE * cell_size.x:
			p1_defend.position.x += delta * SPEED
			p1_defend.position.y = CreateFunction(p1_defend.position.x, data[1][0][0], data[1][0][1], data[1][0][2])
		if p2_defend.position.x > -DEF_RANGE * cell_size.x:
			p2_defend.position.x -= delta * SPEED
			p2_defend.position.y = CreateFunction(-p2_defend.position.x, data[1][1][0], data[1][1][1], data[1][1][2])
	else:
		
		if turn == 1:
			attack_spawn_p1.position.y = border_offset.y + (cell_amount.y /2 -  attack_slider_container.c_slider.value)*cell_size.y
			defend_spawn_p1.position.y = border_offset.y + (cell_amount.y /2 -  defend_slider_container.c_slider.value)*cell_size.y
		elif turn == 2:
			attack_spawn_p2.position.y = border_offset.y + (cell_amount.y /2 -  attack_slider_container.c_slider.value)*cell_size.y
			defend_spawn_p2.position.y = border_offset.y + (cell_amount.y /2 -  defend_slider_container.c_slider.value)*cell_size.y

func _draw(): #drawing playing space and grid lines based on global variables
	draw_rect(Rect2(border_offset, grid_size), Color.LIGHT_GRAY)
	draw_rect(Rect2(border_offset/2, grid_size + border_offset), Color.MIDNIGHT_BLUE, false, border_offset.x)
	
	for line in range(1, cell_amount.x):
		var width = 2
		var color = Color.DIM_GRAY
		if line == cell_amount.x/2:
			width = 4
			color = Color.FIREBRICK
		draw_line(Vector2(cell_size.x * line + border_offset.x, border_offset.y), \
		 		  Vector2(cell_size.x * line + border_offset.x, grid_size.y + border_offset.y), \
				  color, width)
			
	for line in range(1, cell_amount.y):
		var width = 2
		var color = Color.DIM_GRAY
		if line == cell_amount.y/2:
			width = 4
			color = Color.FIREBRICK
		draw_line(Vector2(border_offset.x, cell_size.y * line + border_offset.y), \
				  Vector2(grid_size.x + border_offset.x, cell_size.y * line + border_offset.y), \
				  color, width)

func get_linear(x:float, a: int = 1) -> float:
	var xo = x*(1/cell_size.x)
	return (-a*xo) * cell_size.y
func get_sqr(x:float, a:int = 1, b:int = 0):
	var xo = x*(1/cell_size.x)
	return (-a*pow(xo, 2) -b*xo) * cell_size.y	
func get_sqrt(x:float, a:int = 1):
	var xo = x*(1/cell_size.x)
	return (-a*sqrt(xo)) * cell_size.y
func get_sin(x:float, a:int = 1):
	var xo = x*(1/cell_size.x)
	return (-a*sin(xo)) * cell_size.y
func get_cos(x:float, a:int = 1):
	var xo = x*(1/cell_size.x)
	return (-a*cos(xo)) * cell_size.y
func get_log(x:float, a:int, b:int):
	var xo = x*(1/cell_size.x)
	return (-b*log(xo)/log(a)) * cell_size.y
func get_expo(x:float, a:int, b:int):
	var xo = x*(1/cell_size.x)
	return (-b*pow(a, xo)) * cell_size.y
func CreateFunction(x:float, id:int = 0, a:int = 1, b:int = 0) -> float:
	if id == 1: return get_linear(x, a)
	elif id == 2: return get_sqr(x, a, b)
	elif id == 3: return get_sqrt(x, a)
	elif id == 4: return get_sin(x, a)
	elif id == 5: return get_cos(x, a)
	elif id == 6: return get_log(x, a, b)
	elif id == 7: return get_expo(x, a, b)
	else: return 0

func _on_end_turn_button_up(): #end turn button press
	#finish current turn
	if turn != 0:#p1 attack/defendfunction save
		update_data()
		print(data)
	#next turn setup
	turn += 1
	turn %= 3 #rounds are divided in 3 turns and then they repeat
	
	if turn != 0: 
		
		Global.p1_is_collided = false
		Global.p2_is_collided = false
		
		update_selects()
		reset_sliders()
	
	attack_select.select(0)
	defend_select.select(0)
	
func _on_defend_select_item_selected(index):
	data[1][turn-1][0] = index
	
func _on_attack_select_item_selected(index):
	data[0][turn-1][0] = index
	
func update_selects():
	for idx in range(0, len(available_func[turn - 1])):
		attack_select.set_item_disabled(idx, not available_func[turn - 1][idx])
		defend_select.set_item_disabled(idx, not available_func[turn - 1][idx])
		
func update_data():
	data[0][turn - 1][1] = attack_slider_container.a_slider.value
	data[0][turn - 1][2] = attack_slider_container.b_slider.value
	data[1][turn - 1][1] = defend_slider_container.a_slider.value
	data[1][turn - 1][2] = defend_slider_container.b_slider.value
func reset_sliders():
	attack_slider_container.a_slider.value = 1
	attack_slider_container.b_slider.value = 0
	attack_slider_container.c_slider.value = 1
	
	defend_slider_container.a_slider.value = 1
	defend_slider_container.b_slider.value = 0
	defend_slider_container.c_slider.value = -1
	
func disable_ui():
	attack_select.disabled = true
	defend_select.disabled = true
	
	for child in attack_slider_container.get_children():
		if child is Slider: child.editable = false
	
	for child in defend_slider_container.get_children():
		if child is Slider: child.editable = false
		
	$UI/Hp_Turn/End_Turn.disabled = true
	
func enable_ui():
	attack_select.disabled = false
	defend_select.disabled = false
	
	for child in attack_slider_container.get_children():
		if child is Slider: child.editable = true
	
	for child in defend_slider_container.get_children():
		if child is Slider: child.editable = true
		
	$UI/Hp_Turn/End_Turn.disabled = false
	
