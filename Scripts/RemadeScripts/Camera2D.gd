extends Camera2D

var CAMERA_SPEED := 400
var direction := Vector2(0,0)

func _ready():
	
	limit_left = 0
	limit_top = 0
	limit_right = Global.cell_count.x * Global.cell_size.x + 200
	limit_bottom = Global.cell_count.y * Global.cell_size.y + 200
	
func _process(delta):
	direction = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
		
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		
	position += direction * CAMERA_SPEED * delta
	
