extends Node2D

var trj = preload("res://Scenes/RemadeScenes/UI/trajectory.tscn")

func _ready():
	position.y = Global.cell_count.y/2 * Global.cell_size.y
func _process(_delta):
	pass

func update_trajectories(values:Array):
	for idx in get_child_count():
		get_child(idx).update_trajectory(values[idx][0], values[idx][2])

func create_trajectories():
	clear_trajectories()
	var count
	if Global.turn % 3 == 1:
		count = 0
		position.x = 5 * Global.cell_size.x
	elif Global.turn % 3 == 2:
		count = 1
		position.x = (Global.cell_count.x - 5) * Global.cell_size.x
	for idx in Global.functions_count[count]:
		var trajectory = trj.instantiate()
		trajectory.name = "trajectory_" + str(idx)
		add_child(trajectory)
	pass
	
func clear_trajectories():
	for child in get_children():
		child.queue_free()
