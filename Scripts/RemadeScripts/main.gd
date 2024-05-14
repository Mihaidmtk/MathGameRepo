extends Node2D
var cell_size := Vector2(50, 50)
var cell_count := Vector2(20, 20)

var background_color := Color("052A59")
var grid_color := Color("D93B92")
var grid_color_accent := Color("#F2A0A0")
var grid_color_div := Color("#F2388F")
var border_color := Color("#8C2B86")



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _draw():
	draw_rect(Rect2(0, 0, cell_count.x*cell_size.x + 200, cell_count.y*cell_size.y + 200), background_color)
	for line in range(0, cell_count.x + 1):
		var width = 2
		var color = grid_color
		if line == 0 or line == cell_count.x:
			width = 10
			color = border_color
		elif line == cell_count.x/2:
			width = 4
			color = grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = grid_color_div
		draw_line(Vector2(cell_size.x * line, 5), Vector2(cell_size.x * line, cell_count.y * cell_size.y - 5),color, width)	
	for line in range(0, cell_count.y + 1):
		var width = 2
		var color = grid_color
		if line == 0 or line == cell_count.y:
			width = 10
			color = border_color
		elif line == cell_count.y/2:
			width = 4
			color = grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = grid_color_div
		draw_line(Vector2(5, cell_size.y * line), Vector2(cell_count.x * cell_size.x - 5, cell_size.y * line),color, width)
	

