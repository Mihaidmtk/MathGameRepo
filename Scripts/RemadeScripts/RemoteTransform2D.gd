extends RemoteTransform2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.turn % 4:
		position = Vector2(5*Global.cell_size.x, Global.cell_count.y / 2 * Global.cell_size.y)
	else: position = Vector2((Global.cell_count.x - 5) * Global.cell_size.x, Global.cell_count.y / 2 * Global.cell_size.y)

func update_remote_path(path : NodePath):
	remote_path = path
