@tool
extends Node2D


func _ready():
	print(Global.grid_size.x)
	print(Global.grid_size.y)
	
func _draw(): #drawing playing space and grid lines based on global variables
	draw_rect(Rect2(Global.border_offset, Global.grid_size), Color.LIGHT_GRAY)
	draw_rect(Rect2(Global.border_offset/2, Global.grid_size + Global.border_offset), Color.MIDNIGHT_BLUE, false, Global.border_offset.x)
	
	for line in range(1, Global.cell_amount.x):
		draw_line(Vector2(Global.cell_size.x * line + Global.border_offset.x, Global.border_offset.y), \
		 		  Vector2(Global.cell_size.x * line + Global.border_offset.x, Global.grid_size.y + Global.border_offset.y), \
				  Color.DIM_GRAY, 2)
	for line in range(1, Global.cell_amount.y):
		draw_line(Vector2(Global.border_offset.x, Global.cell_size.y * line + Global.border_offset.y), \
				  Vector2(Global.grid_size.x + Global.border_offset.x, Global.cell_size.y * line + Global.border_offset.y), \
				  Color.DIM_GRAY, 2)
