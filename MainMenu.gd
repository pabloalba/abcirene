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


func _on_btnOpciones_pressed():
	get_tree().change_scene("res://Settings.tscn")


func _on_btnPalabras_pressed():
	get_tree().change_scene("res://Play.tscn")


func _on_btnFrases_pressed():
	# get_tree().change_scene("res://Play.tscn")
	pass
