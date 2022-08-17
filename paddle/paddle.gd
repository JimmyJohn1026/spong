extends KinematicBody2D


var current_state = States.MOVE
enum States {
	MOVE,
	FROZE,
}

export(String) var paddle_side = "left"

var velocity = Vector2.ZERO
var accel = 80
var deaccel = 0.1
var max_speed = 750


func _physics_process(_delta):
	match current_state:
		States.MOVE:
			_move()
		States.FROZE:
			_froze()


func _move():
	if get_input_vector().y != 0:
		velocity.y = clamp(velocity.y + get_input_vector().y * accel, -max_speed, max_speed)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, deaccel)
	velocity = move_and_slide(velocity)


func _froze():
	pass


func get_input_vector():
	var input_dir = Vector2()
	if Input.is_action_pressed(paddle_side + "_up"):
		input_dir.y += -1
	if Input.is_action_pressed(paddle_side + "_down"):
		input_dir.y += 1
	return input_dir


func change_size(new_size): # change polygon and collider bounds
	$Polygon2D.polygon[0].y = -new_size
	$Polygon2D.polygon[1].y = -new_size
	$Polygon2D.polygon[2].y = new_size
	$Polygon2D.polygon[3].y = new_size
	$CollisionShape2D.shape.extents.y = new_size
