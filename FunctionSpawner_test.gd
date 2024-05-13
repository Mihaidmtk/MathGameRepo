extends Node2D
@onready var function_spawner = $function_spawner
@onready var function_spawner_2 = $function_spawner2

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	function_spawner.update_function(0,time*50)
	function_spawner_2.update_function(-time*50, 0)
	pass
