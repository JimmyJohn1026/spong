extends Node


var wave_scene = preload("res://visual/shockwave/shockwave.tscn")


func _ready():
	VisualController.connect("new_shockwave", self, "_make_shockwave")


func _make_shockwave(location):
	var wave_inst = wave_scene.instance()
	wave_inst.material.set("shader_param/center", Vector2(location.x / get_viewport().size.x, 1 - location.y / 1080))
	wave_inst.material.set("shader_param/force", (GameController.ball_speed / 100 - 4) * 0.005)
	add_child(wave_inst)
