extends KinematicBody2D


var wall_particle = preload("res://visual/particle/wall_hit_particle.tscn")

var current_state = States.MOVE
enum States {
	IDLE,
	MOVE,
	FROZE,
}

var velocity = Vector2(GameController.ball_speed, 0)
var paddle_factor = 1.75 # makes the position at witch ball hits paddle matter more


func _physics_process(delta):
	match current_state:
		States.IDLE:
			pass
		States.MOVE:
			_move(delta)
		States.FROZE:
			pass


func _move(delta):
	velocity.x = velocity.x / abs(velocity.x) * GameController.ball_speed # changes speed to what GameController says
	var col_info = move_and_collide(velocity * delta)
	if col_info:
		match col_info.collider.get_collision_layer():
			1: # wall
				velocity = velocity.bounce(col_info.normal)
				var particle_instance = wall_particle.instance()
				particle_instance.process_material.direction = Vector3(col_info.normal.x, col_info.normal.y, 0)
				particle_instance.position = col_info.position
				get_parent().add_child(particle_instance)
				particle_instance.restart()
			2: # paddle
				velocity.x = -velocity.x
				# difference from paddle to ball normalized
				var diff = (position.y - col_info.collider.position.y) / 120
				velocity.y = diff * paddle_factor * abs(velocity.x) # apply vertical velocity
				GameController.paddle_hit()
				VisualController.emit_signal("new_shockwave", col_info.position)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
