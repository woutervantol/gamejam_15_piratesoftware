extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	autoloader.connect("submit", _on_submit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_submit(color):
	$GPUParticles2D.emitting = false
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", global_position + (global_position - get_global_mouse_position()).normalized()*50, 5)
