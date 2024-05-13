extends Control

@export var dropdown_attack_path : NodePath
@onready var dropdown_attack = get_node(dropdown_attack_path)

@export var dropdown_defend_path : NodePath
@onready var dropdown_defend = get_node(dropdown_defend_path)

@onready var attack_slider_container = $"FuncSelection/attack_func/attack_slider_container"
@onready var defend_slider_container = $"FuncSelection/defend_func/defend_slider_container"

var attack_selected: int = 0
var defend_selected: int = 0

#DROPDOWN ID_LEGEND
# 0: default/none
# 1: linear
# 2: sqr
# 3: sqrt
# 4: sin
# 5: cos
# 6: loga
# 7: a^x

func _ready():
	#attack
	dropdown_attack.add_item("nimic")
	dropdown_attack.add_item("ax + c")
	dropdown_attack.add_item("ax² + bx + c")
	dropdown_attack.add_item("a*√x + c")
	dropdown_attack.add_item("a*sinx + c")
	dropdown_attack.add_item("a*cosx + c")
	dropdown_attack.add_item("b*logₐx + c")
	dropdown_attack.add_item("b*aˣ + c")
	
	#defend
	dropdown_defend.add_item("nimic")
	dropdown_defend.add_item("ax + b")
	dropdown_defend.add_item("ax² + bx + c")
	dropdown_defend.add_item("a*√x + c")
	dropdown_defend.add_item("a*sinx + c")
	dropdown_defend.add_item("a*cosx + c")
	dropdown_defend.add_item("b*logₐx + c")
	dropdown_defend.add_item("b*aˣ + c")
	
	#disable items at start
	for idx in range(3,dropdown_attack.item_count):
		dropdown_attack.set_item_disabled(idx, true)
		dropdown_defend.set_item_disabled(idx, true)


func _on_attack_select_item_selected(index):
	dropdown_defend.set_item_disabled(attack_selected, false)
	if index != 0:
		dropdown_defend.set_item_disabled(index, true)
		attack_selected = index
	

func _on_defend_select_item_selected(index):
	dropdown_attack.set_item_disabled(defend_selected, false)
	if index != 0:
		dropdown_attack.set_item_disabled(index, true)
		defend_selected = index