extends Node2D

var fow_cell = preload("res://Scenes/RemadeScenes/fow_cell.tscn")
@export var player:int
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Global.cell_count.x):
		for j in range(Global.cell_count.y):
			if player == 1:
				if i > 10:
					var c := fow_cell.instantiate()
					c.position = Vector2(i*Global.cell_size.x, j*Global.cell_size.y)
					c.player = 1
					add_child(c)
			else:
				if i < Global.cell_count.x - 10:
					var c := fow_cell.instantiate()
					c.position = Vector2(i*Global.cell_size.x, j*Global.cell_size.y)
					c.player = 2
					add_child(c)
	pass # Replace with function body.
func _process(delta):
	pass
