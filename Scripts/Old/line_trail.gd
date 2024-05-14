extends Line2D
class_name Trail

@onready var timer = $Timer
@onready var curve := Curve2D.new()

var MAX_POINTS = 2000

func _process(delta: float) -> void:
	position = get_parent().get_parent().position
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	points = curve.get_baked_points()
	

