extends Node2D
var rng = RandomNumberGenerator.new()

var obsh = preload("res://Scenes/RemadeScenes/obstacle_h.tscn")
var obsv = preload("res://Scenes/RemadeScenes/obstacle_v.tscn")
var ppw = preload("res://Scenes/RemadeScenes/powerup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Global.cell_count * Global.cell_size /2
	pass # Replace with function body.

func generate_field():
	for i in range(-15, 16, 2):
		for j in range(-14, 15, 2):
			var random_number = rng.randf_range(0,1)
			if random_number < 0.1:
				var new_obj
				if random_number < 0.05: new_obj = obsh.instantiate()
				else: new_obj = obsv.instantiate()
				new_obj.position = Vector2(Global.cell_size.x * i, Global.cell_size.y * j)
				add_child(new_obj)
			
			elif random_number > 0.90:
				if i > -8 and i < 8 and j < 7 and j > -7:
					var b
					var buff_rng = rng.randf_range(0,1)
					if buff_rng < 0.9:
						if buff_rng <0.7:
							b = 1
						else: b = 0
					else: b = 2
					var t = rng.randi_range(1, 5)
					var new_ppw = ppw.instantiate()
					new_ppw.set_powerup(b, t)
					new_ppw.position = Vector2(Global.cell_size.x * i, Global.cell_size.y * j)
					add_child(new_ppw)

func clear_field():
	for child in get_children():
		child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
