extends Control


func _ready():
	GameController.connect("left_win", self, "_left_win")
	GameController.connect("right_win", self, "_right_win")

func _left_win():
	$LeftWin.show()
	$Reset.show()

func _right_win():
	$RightWin.show()
	$Reset.show()
