extends Node2D

@onready var function_head = $function_head
@onready var body = $function_head/body
@onready var curve := Curve2D.new()
@onready var timer = $function_head/body/Timer
@onready var head_collider = $function_head/head_collider


var segments : Array
var should_update_shape := true
var is_collided := false
var type := 0
var mode := 0
var integrated := 0


func _ready():
	pass
	

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

func _on_collider_area_entered(area):
	if area.get_parent().get_parent() != get_parent():
		if area.is_in_group("obstacle"):
			reset_function()
		elif mode == 0:
			if area.mode == 1: reset_function()
		elif mode == 1:
			if area.mode == 2: reset_function()
		elif mode == 2:
			if area.mode == 0 or area.mode == 2: reset_function()
	
func set_function(m:int, t:int):
	top_level = true
	if get_parent().player == 1:
		position.x = Global.cell_size.x * 5
	else: position.x = (Global.cell_count.x - 5) * Global.cell_size.x
	position.y = Global.cell_count.y/2 * Global.cell_size.y
	mode = m
	type = t
	body.top_level = true
	body.position = position
	is_collided = false
	if m == 0: #Attack
		body.modulate = Color("#FF37A1")
		$collider.add_to_group("atac")
	elif m == 1:
		body.modulate = Color("#00DF9A")
		$collider.add_to_group("apărare")
	elif m == 2:
		body.modulate = Color("#E1FF62")
		$collider.add_to_group("recunoaștere")
		
