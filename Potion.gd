extends Area2D

var mouse_over = false
var dragging = false
var overlapping = false
var nr_merges = 1
var color = Vector3(randf(), randf(), randf()).normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Color.modulate = Color(color[0], color[1], color[2])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_over and Input.is_action_just_pressed("mouse_left"):
		dragging = true
		z_index = 1
		$Shadow.position.y = 25

	if dragging:
		if overlapping:
			var overlaps = get_overlapping_areas()
			overlaps[get_closest_overlap()].find_child("Outline").visible = true

		if Input.is_action_just_released("mouse_left"):
			z_index = 0
			$Shadow.position.y = 15
			global_position.y += 10
			dragging = false
			var selected
			if get_overlapping_areas():
				selected = get_overlapping_areas()[get_closest_overlap()]
			if selected:
				if selected.name == "obscuration":
					autoloader.emit_signal("submit", color)
				else:
					selected.merge(color)
				queue_free()
				mouse_over = false
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		else:
			global_position = get_global_mouse_position()

func get_closest_overlap():
	var overlaps = get_overlapping_areas()
	var closest_id = 0
	var closest_dist = INF
	if len(overlaps) == 1:
		closest_id = 0
	else:
		for i in range(len(overlaps)):
			if (global_position - overlaps[i].global_position).length() < closest_dist:
				closest_dist = (global_position - overlaps[i].global_position).length()
				closest_id = i
	return closest_id

func merge(other_color):
	color = (color * nr_merges + other_color).normalized()
	$Color.modulate = Color(color[0], color[1], color[2])
	nr_merges += 1
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	#scale += Vector2(0.05, 0.05)
	if nr_merges == 3:
		$Bottle.texture = load("res://potion_4_bottle.png")
		$Color.texture = load("res://potion_4_color.png")
		$Shade.texture = load("res://potion_4_shade.png")
		$Outline.texture = load("res://potion_4_outline.png")
	elif nr_merges == 5:
		$Bottle.texture = load("res://potion_3_bottle.png")
		$Color.texture = load("res://potion_3_color.png")
		$Shade.texture = load("res://potion_3_shade.png")
		$Outline.texture = load("res://potion_3_outline.png")
	elif nr_merges == 8:
		$Bottle.texture = load("res://potion_2_bottle.png")
		$Color.texture = load("res://potion_2_color.png")
		$Shade.texture = load("res://potion_2_shade.png")
		$Outline.texture = load("res://potion_2_outline.png")
	elif nr_merges == 12:
		$Bottle.texture = load("res://potion_1_bottle.png")
		$Color.texture = load("res://potion_1_color.png")
		$Shade.texture = load("res://potion_1_shade.png")
		$Outline.texture = load("res://potion_1_outline.png")
 
func _on_mouse_entered():
	mouse_over = true
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)


func _on_mouse_exited():
	mouse_over = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_area_entered(area):
	overlapping = true


func _on_area_exited(area):
	overlapping = false
	$Outline.visible = false
