extends Sprite2D

var bg_number = 0
var bg_array = []

var screenSize = DisplayServer.window_get_size()


func change_bg():
	texture = bg_array[bg_number]
	bg_number += 1
	if bg_number >= bg_array.size():
		bg_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	var order_file = File.new()
	var order_file = FileAccess.open("res://bg-order.config", FileAccess.READ)
	var order_arr = order_file.get_as_text().split("\n")
	order_file.close()
	print(order_arr.size())
	for n in order_arr.size():
		bg_array.append(load("res://Assets/backgrounds/" + order_arr[n] + ".png"))
#		bg_array[n].resize(screenSize.x, screenSize.y)
	print(bg_array[0])
	change_bg()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Background_Swap_timeout():
	change_bg()
#	pass
