extends Node


func _process(_delta):
	$LeftLight.modulate = GameController.left_color
	$RightLight.modulate = GameController.right_color
