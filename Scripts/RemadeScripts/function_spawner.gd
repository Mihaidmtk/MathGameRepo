extends Node2D
class_name FunctionSpawner

@onready var function_head = $function_head
@onready var body = $function_head/body
@onready var curve := Curve2D.new()
@onready var timer = $function_head/body/Timer
@onready var collider = $collider


var segments : Array
var should_update_shape := true
var is_collided := false
var player :int
var type := 4
var mode := 0
var coeff := Vector3(1,0,0)
var integrated := 0

var curr_p := Vector2(0,0)
var prev_p := Vector2(0,0)

func _ready():
	function_head.visible = false
	pass
func _process(_delta):
	pass
	
func update_function(sim_time:float) -> void:
	if !is_collided:
		function_head.visible = true
		
		if mode == 1:
			sim_time *= 1
		elif mode == 2:
			sim_time *= 1.1
		
		if player == 1:
			function_head.position = Vector2(sim_time, Global.Function(sim_time, type, coeff))
		else: 
			function_head.position = Vector2(-sim_time, Global.Function(sim_time, type, coeff))
		body.position = position
		curve.add_point(function_head.position)
		body.points = curve.get_baked_points()
		if should_update_shape:
			should_update_shape = false
			timer.start()

func reset_function():
	is_collided = true
	$function_head/head.visible = false
	if mode != 1 :clear_all_shape()
	
func create_segment(p1 : Vector2, p2 : Vector2) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2
	return collision
	
func clear_all_shape():
	#for c in collider.get_children():
		#c.queue_free()
	#curve.clear_points()
	#body.points.clear()
	queue_free()
	
func update_collision_shape():
	var n = body.points.size()
	integrated = collider.get_child_count()
	print(n," ",integrated)
	if n - integrated > 2:
		segments.clear()
		for i in range(integrated, n - 1):
			segments.append(create_segment(body.points[i], body.points[i+1]))
			#print(segments)
			#segments.append(create_circle(body.points[i]))
		for s in segments: collider.add_child(s)
		print(collider.get_child_count())

func _on_timer_timeout():
	if collider.get_child_count() == 1:
		prev_p = body.points[0]
	curr_p = function_head.position
	should_update_shape = true
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = prev_p
	collision.shape.b = curr_p
	if !is_collided:
		collider.add_child(collision)
	prev_p = curr_p
	
func _on_collider_area_entered(area):
	if area.is_in_group("bound"): clear_all_shape()
	elif area.is_in_group("player"): reset_function()
	elif area.is_in_group("powerup"): pass
	elif area.is_in_group("obstacle"): reset_function()
	elif area.get_parent() is FunctionSpawner and player != area.get_parent().player:
		if mode == 0:
			if area.get_parent().mode == 1: reset_function()
		elif mode == 1:
			if area.get_parent().mode == 2: reset_function()
		elif mode == 2:
			if area.get_parent().mode == 0 or area.get_parent().mode == 2: reset_function()
	
func set_function(p:int, t:int, m:int, c:Vector3):
	player = p
	mode = m
	type = t
	coeff = c
	is_collided = false
	if type == 0:
		reset_function()
	if player == 1:
		position.x = Global.cell_size.x * 5
	else: position.x = (Global.cell_count.x - 5) * Global.cell_size.x
	position.y = Global.cell_count.y/2 * Global.cell_size.y
	
	body.top_level = true
	body.position = position
	if m == 0: #Attack
		body.modulate = Color("#FF37A1")
		collider.add_to_group("atac")
	elif m == 1:
		body.modulate = Color("#00DF9A")
		collider.add_to_group("apărare")
	elif m == 2:
		body.modulate = Color("#E1FF62")
		collider.add_to_group("recunoaștere")

