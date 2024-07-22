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
			if get_overlapping_areas():
				get_overlapping_areas()[get_closest_overlap()].merge(color)
				queue_free()
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
