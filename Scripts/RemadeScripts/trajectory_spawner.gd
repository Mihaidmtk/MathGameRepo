extends Node2D

var trj = preload("res://Scenes/RemadeScenes/UI/trajectory.tscn")

func _ready():
	position.y = Global.cell_count.y/2 * Global.cell_size.y
func _process(delta):
	pass
	
func create_trajectories():
	for child in get_children():
		child.queue_free()
	var count
	if Global.turn % 4 == 1:
		count = 0
		position.x = 5 * Global.cell_size.x
	elif Global.turn % 4 == 3:
		count = 1
		position.x = (Global.cell_count.x - 5) * Global.cell_size.x
	for idx in Global.functions_count[count]:
		var trajectory = trj.instantiate()
		trajectory.name = "trajectory_" + str(idx)
		add_child(trajectory)
	pass
	
	
