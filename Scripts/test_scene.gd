@tool
extends Node2D

var cell_size := Vector2(50, 50)
var cell_amount := Vector2(20,10)
var grid_size := Vector2(1000, 500)
var border_offset := Vector2(10,10)

func _ready():
	pass
	
func _draw(): #drawing playing space and grid lines based on global variables
	if Engine.is_editor_hint():
		draw_rect(Rect2(border_offset, grid_size), Color.LIGHT_GRAY)
		draw_rect(Rect2(border_offset/2, grid_size + border_offset), Color.MIDNIGHT_BLUE, false, border_offset.x)
		
		for line in range(1, cell_amount.x):
			draw_line(Vector2(cell_size.x * line + border_offset.x, border_offset.y), \
			 		  Vector2(cell_size.x * line + border_offset.x, grid_size.y + border_offset.y), \
					  Color.DIM_GRAY, 2)
		for line in range(1, cell_amount.y):
			draw_line(Vector2(border_offset.x, cell_size.y * line + border_offset.y), \
					  Vector2(grid_size.x + border_offset.x, cell_size.y * line + border_offset.y), \
					  Color.DIM_GRAY, 2)
