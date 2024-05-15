extends Node2D

var sim_time = 0
@onready var function_spawner = $function_spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sim_time += delta * 100
	function_spawner.update_function(-sim_time)
	pass
