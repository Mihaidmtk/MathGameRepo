extends Node2D

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _draw():
	draw_rect(Rect2(0, 0, Global.cell_count.x*Global.cell_size.x + 200, Global.cell_count.y*Global.cell_size.y + 200), Global.background_color)
	for line in range(0, Global.cell_count.x + 1):
		var width = 2
		var color = Global.grid_color
		if line == 0 or line == Global.cell_count.x:
			width = 10
			color = Global.border_color
		elif line == Global.cell_count.x/2:
			width = 4
			color = Global.grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = Global.grid_color_div
		draw_line(Vector2(Global.cell_size.x * line, 5), Vector2(Global.cell_size.x * line, Global.cell_count.y * Global.cell_size.y - 5),color, width)	
	for line in range(0, Global.cell_count.y + 1):
		var width = 2
		var color = Global.grid_color
		if line == 0 or line == Global.cell_count.y:
			width = 10
			color = Global.border_color
		elif line == Global.cell_count.y/2:
			width = 4
			color = Global.grid_color_accent
		elif line % 5 == 0:
			width = 4
			color = Global.grid_color_div
		draw_line(Vector2(5, Global.cell_size.y * line), Vector2(Global.cell_count.x * Global.cell_size.x - 5, Global.cell_size.y * line),color, width)

