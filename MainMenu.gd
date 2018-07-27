extends ColorRect

func _ready():
	globals.load_game()	

func _on_BtnPlay_pressed():
	get_tree().change_scene("res://Play.tscn")

func _on_btnSettings_pressed():
	get_tree().change_scene("res://Settings.tscn")

func _on_btnWords_pressed():
	globals.play_word = true
	get_tree().change_scene("res://Play.tscn")

func _on_btnPhrases_pressed():
	globals.play_word = false
	get_tree().change_scene("res://Play.tscn")
	
