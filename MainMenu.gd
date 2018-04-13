extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	globals.load_game()	

func _on_BtnOptions_pressed():
	get_tree().change_scene("res://Options.tscn")


func _on_BtnPlay_pressed():
	get_tree().change_scene("res://Play.tscn")
