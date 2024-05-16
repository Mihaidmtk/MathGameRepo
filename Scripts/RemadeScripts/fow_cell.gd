extends Node2D

var player:int

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("recunoaștere"):
		if area.get_parent().player == player:
			queue_free()
