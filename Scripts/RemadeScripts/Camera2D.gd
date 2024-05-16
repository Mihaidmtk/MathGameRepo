extends Camera2D

var CAMERA_SPEED := 400
var direction := Vector2(0,0)

var camera_size := Vector2(1920, 1080)

var disable_movement := false

var camera_limit_left = camera_size.x/2
var camera_limit_top = camera_size.y/2 - 170
var camera_limit_right = Global.cell_count.x * Global.cell_size.x - camera_size.x/2 
var camera_limit_bottom = Global.cell_count.y * Global.cell_size.y -camera_size.y/2

func _ready():
	pass
func _process(delta):
	direction = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if !disable_movement:
		position += direction * CAMERA_SPEED * delta
	if position.x > camera_limit_right: position.x = camera_limit_right
	elif position.x < camera_limit_left: position.x = camera_limit_left
	if position.y < camera_limit_top: position.y = camera_limit_top
	elif position.y > camera_limit_bottom: position.y = camera_limit_bottom
	
