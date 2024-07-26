extends Area2D

@onready var cloudobject = preload("res://cloud.tscn")
@onready var splatobject = preload("res://splat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	autoloader.connect("submit", _on_submit)
	var cloudpoints = [-30, -20, -10, 0, 10, 20, 30]
	for x in cloudpoints:
		for y in cloudpoints:
			var pos = Vector2(x, y)
			var cloud = cloudobject.instantiate()
			cloud.position = pos
			cloud.get_child(0).preprocess = randf_range(0, 10)
			add_child(cloud)


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if $Outline.visible:
		#if Input.is_action_just_released("mouse_left"):
			#autoloader.emit_signal("drop_potion")

func _on_submit(color):
	$Outline.visible = false
	var splat = splatobject.instantiate()
	splat.global_position = get_global_mouse_position()
	splat.modulate = Color(color[0], color[1], color[2])
	splat.rotation = randf_range(0, 2*PI)
	get_parent().add_child(splat)
	print(splat)

func _on_area_exited(area):
	$Outline.visible = false
