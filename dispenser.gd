extends Area2D

@export var color = Vector3(1, 1, 1)
var potion_obj = preload("res://Potion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.3).timeout
	create_potion()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_potion():
	var potion = potion_obj.instantiate()
	potion.color = color
	potion.global_position = global_position
	get_parent().call_deferred("add_child", potion)

func _on_area_exited(area):
	if len(get_overlapping_areas()) == 0:
		create_potion()
