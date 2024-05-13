extends Node2D
class_name FunctionSpawner

@onready var function_head = $function_head
@onready var body = $function_head/body
@onready var curve := Curve2D.new()
@onready var timer = $function_head/body/Timer
@onready var head_collider = $function_head/head_collider


var segments : Array
var should_update_shape := true
var integrated := 0


func _ready():
	body.modulate = Color.REBECCA_PURPLE
	body.top_level = true
	body.position = position

func _process(_delta):
	pass
func update_function(x : float, y: float) -> void:
	function_head.visible = true
	function_head.position = Vector2(x,y)
	body.position = position
	curve.add_point(function_head.position)
	body.points = curve.get_baked_points()
	if should_update_shape:
		update_collision_shape()
		should_update_shape = false
		timer.start()

func reset_function():
	clear_all_shape()
	function_head.visible = false
	

func create_segment(p1 : Vector2, p2 : Vector2) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2
	return collision
	
func clear_all_shape():
	for c in $collider.get_children():
		c.queue_free()
	curve.clear_points()
	body.points.clear()
	
func update_collision_shape():
	var n = body.points.size()
	integrated = $collider.get_child_count()
	if n - integrated < 2: return
	segments.clear()
	for i in range(integrated, n-1):
		segments.append(create_segment(body.points[i], body.points[i+1]))
	for s in segments: $collider.add_child(s)

func _on_timer_timeout():
	should_update_shape = true

func _on_collider_area_entered(_area):
	reset_function()
	
static func create() -> FunctionSpawner:
	var scn = preload("res://Scenes/RemadeScenes/GameLogic/function_spawner.tscn")
	return scn.instantiate()
