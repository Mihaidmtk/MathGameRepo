extends Node2D

@onready var spawners = $spawners
@onready var sim_spawners = $sim_spawners

var FunctionSpawner = preload("res://Scenes/RemadeScenes/GameLogic/function_spawner.tscn")
var player :int

func _ready():
	pass
func _process(_delta):
	pass

func create_sim_function_spawner(mode : int):
	for spawner in sim_spawners.get_children():
		spawner.queue_free()
	for idx in Global.functions_count[player - 1]:
		var spawner = FunctionSpawner.instantiate()
		spawner.mode = mode
		spawner.set_function(mode)
		sim_spawners.add_child(spawner)

func _on_area_2d_area_entered(area):
	if area.is_in_group("atac"):
		if (Global.turn % 4 == 0 and player == 1) or (Global.turn % 4 == 2 and player == 2): 
			if player == 1: Global.p1_health -= 1
			else: Global.p2_health -= 1
