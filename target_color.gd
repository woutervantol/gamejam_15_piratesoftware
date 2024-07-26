extends Node2D

var target = Vector3(randf(), randf(), randf())

# Called when the node enters the scene tree for the first time.
func _ready():
	autoloader.connect("submit", _on_submit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_submit(color):
	print(color)
	print($ColorRect3.color)
	var colordiff = (color - Vector3($ColorRect3.color.r, $ColorRect3.color.g, $ColorRect3.color.b)).length()
	var angle = color.angle_to(Vector3($ColorRect3.color.r, $ColorRect3.color.g, $ColorRect3.color.b))
	var score = (PI/2 - angle)/(PI/2)
	print(angle, score)
	print("%.1f" % (100*score) + "%")

func _on_button_button_down():
	var target = Vector3(randf_range(0.2, 0.8), randf_range(0.2, 0.8), randf_range(0.2, 0.8)).normalized()
	var axes = [
		Vector3(1, 1, 0).normalized(),
		Vector3(1, 0, 1).normalized(),
		Vector3(0, 0, 1).normalized()
	]
	var axis = axes[randi_range(0, 2)]
	#var axis = target.cross(Vector3(randf(), randf(), randf()).normalized()).normalized()

	var rotangle = 0.1
	var left = target.rotated(axis, rotangle)
	var leftleft = target.rotated(axis, 2*rotangle)
	var right = target.rotated(axis, -rotangle)
	var rightright = target.rotated(axis, -2*rotangle)
	$ColorRect.color = Color(leftleft[0], leftleft[1], leftleft[2])
	$ColorRect2.color = Color(left[0], left[1], left[2])
	$ColorRect3.color = Color(target[0], target[1], target[2])
	#$ColorRect3.color = Color(0, 0, 0, 0)
	$ColorRect4.color = Color(right[0], right[1], right[2])
	$ColorRect5.color = Color(rightright[0], rightright[1], rightright[2])

