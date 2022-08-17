extends Node2D


var ball_scene = preload("res://ball/ball.tscn")


func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func _ready():
	instance_ball()


func instance_ball():
	var ball_i = ball_scene.instance()
	ball_i.position = Vector2(960, 540)
	add_child(ball_i)
