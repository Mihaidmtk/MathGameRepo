extends Node

var is_dragging = false
var cell_size := Vector2(50, 50)
var cell_amount := Vector2(20,10)
var grid_size := Vector2(cell_size.x * cell_amount.x, cell_size.y * cell_amount.y)

var border_offset := Vector2(10,10)


