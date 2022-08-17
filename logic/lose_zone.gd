extends Area2D


export(String) var side = "left"


func _on_ball_entered(body):
	body.set_collision_mask_bit(1, false)
	GameController.lose(side)
