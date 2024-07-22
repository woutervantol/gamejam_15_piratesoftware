extends Node2D

var color = Vector3(1, 1, 1).normalized()
var clicks = 0
var multiplier = 5

func _ready():
	color = Vector3(sqrt(color[0]), sqrt(color[1]), sqrt(color[2]))
	$TextureRect.modulate = Color(color[0], color[1], color[2])
	
	var crand = Vector3(randf(), randf(), randf()).normalized()
	$TextureRect2.modulate = Color(crand[0], crand[1], crand[2])
	$Label2.text = "R: "+str(crand[0]) + "\nG: "+str(crand[1])+"\nB: "+str(crand[2])


func set_color(c):
	c = c.normalized()
	#c = Vector3((c[0])**2, (c[1])**2, (c[2])**2)
	color = c
	$TextureRect.modulate = Color(c[0], c[1], c[2])
	$Label.text = "R: "+str(c[0]) + "\nG: "+str(c[1])+"\nB: "+str(c[2]) + "\n%.1f" % (100*(sqrt(2) - (c - Vector3($TextureRect2.modulate.r, $TextureRect2.modulate.g, $TextureRect2.modulate.b)).length())/sqrt(2))
	$Label.text += "%"

func _on_red_button_down():
	set_color(color*clicks + Vector3(1, 0, 0))
	clicks += 1


func _on_green_button_down():
	set_color(color*clicks + Vector3(0, 1, 0))
	clicks += 1


func _on_blue_button_down():
	set_color(color*clicks + Vector3(0, 0, 1))
	clicks += 1


func _on_add_button_down():
	var c = color*multiplier + Vector3($TextureRect3.modulate.r, $TextureRect3.modulate.g, $TextureRect3.modulate.b)
	c = c.normalized()
	$TextureRect3.modulate = Color(c[0], c[1], c[2])
	$Label3.text = "R: "+str(c[0]) + "\nG: "+str(c[1])+"\nB: "+str(c[2])
	clicks = 0


func _on_v_slider_value_changed(value):
	multiplier = value
