extends Node2D

@onready var area_2d = $Area2D
@onready var label = $Label

var buff :int # 0: unlock func, 1: unlock type 2: hp+
var type :int

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false
	if buff == 0: modulate = Color("#04F570")
	elif buff == 1: pass
	elif buff == 2: modulate = Color("#F29F05")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_powerup(b:int, t:int):
	buff = b
	type = t
	#change color
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("atac") or area.is_in_group("apărare") or area.is_in_group("recunoaștere"):
		print("what")
		area_2d.monitorable = false
		area_2d.monitoring = false
		#update Globals
		var p = area.get_parent().player
		if buff == 0:
			if Global.functions_count[p-1] >= Global.max_func_count:
				label.text = "număr maxim de funcții"
			else:
				Global.functions_count[p-1] += 1
				label.text = "+1 funcții!"
		elif buff == 1:
			if Global.unlocked[p-1][type]:
				label.text = "funcția: "+Global.functions_dict[type] + " deja deblocată"
			else: 
				Global.unlocked[p-1][type] = 1
				label.text = "+" +Global.functions_dict[type]+"!"
		elif buff == 2:
			if Global.health[p-1] == 3:
				label.text == "viața deja la maxim"
			else:
				Global.health[p-1] += 1
				label.tect += "+1 viață"
			
		#play animation
		$Sprite2D.visible = false
		label.visible = true
		var tw = get_tree().create_tween()
		tw.tween_property(label, "modulate:a", 0.0, 1.0)
		tw.tween_property(label, "position:y", 25, 1.0)
		await tw.finished
		queue_free()

