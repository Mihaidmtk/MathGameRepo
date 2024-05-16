extends Node2D

@onready var sim_spawners = $sim_spawners

var function_spawner := preload("res://Scenes/RemadeScenes/GameLogic/function_spawner.tscn")
@export var player :int

func _ready():
	pass
func _process(_delta):
	pass

func create_sim_function_spawner(mode : int):
	for spawner in sim_spawners.get_children():
		spawner.queue_free()
	for idx in Global.functions_count[player - 1]:
		var spawner = function_spawner.instantiate()
		spawner.mode = mode
		spawner.set_function(mode)
		sim_spawners.add_child(spawner)

func clear_sim_function():
	for spawner in sim_spawners.get_children():
		if spawner is FunctionSpawner:
			spawner.queue_free()

func is_all_collided():
	for spawner in sim_spawners.get_children():
		if spawner.is_collided == false: return false
	return true
func _on_area_2d_area_entered(area):
	if area.is_in_group("atac"):
		if player == 1: Global.health[0] -= 1
		else: Global.health[1] -= 1
