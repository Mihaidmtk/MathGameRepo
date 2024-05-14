extends Node2D
@onready var function_spawner = $function_spawner
@onready var function_spawner_2 = $function_spawner2

var f1 := FunctionSpawner.create()
var f2 := FunctionSpawner.create() 

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(f1)
	add_child(f2)
	f2.position = Vector2(200, 200)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	f2.update_function(time*100, time*50)
	pass
