extends Node

# vars to control game
export(Gradient) var score_gradient # color gradient for score
var left_color
var right_color

signal left_win
signal right_win

var goal = 7.0 # score to win
var gradient_weight = 0.2 # how quickly the colors change
var left_f = 0.0 # used for interpolating colore
var left_score = 0.0
var right_f = 0.0
var right_score = 0.0
var ball_speed = 400
var speed_inc = 100

var hits = 0
var grouping = 4


func _ready():
	left_color = score_gradient.interpolate(0)
	right_color = score_gradient.interpolate(0)


func _process(delta):
	left_f = lerp(left_f, left_score, gradient_weight * delta)
	left_color = score_gradient.interpolate(left_f / goal)
	right_f = lerp(right_f, right_score, gradient_weight * delta)
	right_color = score_gradient.interpolate(right_f / goal)


func paddle_hit():
	hits += 1
	
	if hits % grouping == 0:
		ball_speed += speed_inc


func lose(side):
	if side == "left":
		right_score += 1.0
		if right_score >= 7:
			emit_signal("right_win")
			return
	elif side == "right":
		left_score += 1.0
		if left_score >= 7:
			emit_signal("left_win")
			return
	_randomize_bg()
	$ResetTimer.start()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_randomize_bg()
	if Input.is_action_just_pressed("reset"):
		ball_speed = 400
		left_score = 0
		right_score = 0
		get_tree().change_scene("res://main.tscn")


func _on_ResetTimer_timeout():
	ball_speed = (left_score + right_score) * 100 + 400
	get_node("/root/Main").instance_ball()


var bgs = [
	preload("res://visual/background/circles/circles.tscn"),
	preload("res://visual/background/pillars/pillars.tscn"),
	preload("res://visual/background/v_lines/v_lines.tscn"),
]
var rng = RandomNumberGenerator.new()

func _randomize_bg():
	rng.randomize()
	var bg = bgs[rng.randi_range(0, 2)]
	var bg_i = bg.instance()
	get_node("/root/Main/Background").get_child(0).queue_free()
	get_node("/root/Main/Background").add_child(bg_i)
