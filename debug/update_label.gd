extends Label


export(String) var game_var = "left_score"


func _process(_delta):
	text = String(GameController.get(game_var))
