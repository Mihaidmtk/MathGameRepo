extends Node2D
class_name AttackLine

var player

func _on_area_2d_area_entered(area):
	print("body entered")
	if area.is_in_group("obstacle"):
		print("destroy obstacle")
		area.get_parent().queue_free()
	elif area.is_in_group("powerup"):
		pass
	elif area.is_in_group("enemy"):
		pass
	if player == 1: Global.p1_is_collided = true
	elif player == 2: Global.p2_is_collided = true
	self.queue_free()
	
static func create() -> AttackLine:
	var scn = preload("res://Scenes/attack_line.tscn")
	return scn.instantiate()
