extends Line2D

@onready var curve := Curve2D.new()
@onready var timer = $Timer
var segments : Array
var should_update_shape := true
var integrated := 0

func _ready():
	default_color = Color.REBECCA_PURPLE
	points = [Vector2(0, 0), Vector2(50, 50), Vector2(75,75)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = get_parent().get_parent().position
	curve.add_point(get_parent().position)
	points = curve.get_baked_points()
	if should_update_shape:
		update_collision_shape()
		should_update_shape = false
		timer.start()

func create_segment(p1 : Vector2, p2 : Vector2) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2
	return collision
	
func clear_all_shape():
	for c in $collider.get_children():
		c.queue_free()
	
func update_collision_shape():
	var n = points.size()
	integrated = $collider.get_child_count() + 1
	if n - integrated < 2: return
	segments.clear()
	for i in range(integrated, n-1):
		segments.append(create_segment(points[i], points[i+1]))
	for s in segments: $collider.add_child(s)

func _on_timer_timeout():
	should_update_shape = true
