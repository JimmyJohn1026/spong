extends Node

# vars to control game
export(Gradient) var score_gradient # color gradient for score
var left_color
var right_color

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
	elif side == "right":
		left_score += 1.0
	$ResetTimer.start()


func _on_ResetTimer_timeout():
	ball_speed = (left_score + right_score) * 100 + 400
	get_node("/root/Main").instance_ball()
