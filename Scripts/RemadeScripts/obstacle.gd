extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("atac") or area.is_in_group("powerup"):
		queue_free()
