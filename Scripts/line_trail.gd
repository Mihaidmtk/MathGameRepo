extends Line2D
class_name Trail

@onready var timer = $Timer
@onready var curve := Curve2D.new()

var MAX_POINTS = 1000
var should_add_point : bool = true

func _process(delta: float) -> void:
	if should_add_point:
		should_add_point = false
		timer.start()
		curve.add_point(get_parent().position)
		if curve.get_baked_points().size() > MAX_POINTS:
			curve.remove_point(0)
		points = curve.get_baked_points()
	
func stop() -> void:
	set_process(false)
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 2.0)
	await  tw.finished
	queue_free()
	
static func create() -> Trail:
	var scn = preload("res://Scenes/trail.tscn")
	return scn.instantiate()


func _on_timer_timeout():
	should_add_point = true
