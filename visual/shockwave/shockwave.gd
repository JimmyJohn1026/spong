extends TextureRect


var shockwave_speed = 2


func _process(delta):
	# make shockwave bigger
	material.set("shader_param/size", material.get("shader_param/size") + shockwave_speed * delta)


func _on_Timer_timeout():
	queue_free()
