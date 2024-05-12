extends Node2D

var dragable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

var current_trail : Trail

func _process(_delta):
	if dragable:
		if Input.is_action_just_pressed("mouse_click"):
			initialPos = global_position
			offset = get_global_mouse_position() - initialPos
			Global.is_dragging = true
		if Input.is_action_pressed("mouse_click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("mouse_click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "position", body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)




func _on_area_2d_mouse_entered():
	if !Global.is_dragging:
		dragable = true
		scale = Vector2(1.05, 1.05)
		make_trail()

func _on_area_2d_mouse_exited():
	if !Global.is_dragging:
		dragable = false
		scale = Vector2(1, 1)
		current_trail.stop()

func _on_area_2d_body_entered(body):
	if body.is_in_group("droppable"):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("droppable"):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func make_trail():
	if current_trail: current_trail.stop()
	current_trail = Trail.create()
	add_child(current_trail)
	pass
		

