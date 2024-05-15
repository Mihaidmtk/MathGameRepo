extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.position = Vector2.ZERO
	$Area2D/CollisionShape2D2.position = Vector2.ZERO
	$Area2D/CollisionShape2D3.position = Global.cell_count * Global.cell_size
	$Area2D/CollisionShape2D4.position = Global.cell_count * Global.cell_size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
