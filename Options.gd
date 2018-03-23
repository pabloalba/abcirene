extends ColorRect

func _ready():
	_load_old_options()
	
func _load_old_options():
	
	
	get_node("VBoxContainer/HBoxContainer/ChkFewLetters").set_pressed(!globals.all_alphabet)
	get_node("VBoxContainer/HBoxContainer/ChkAllLetters").set_pressed(globals.all_alphabet)
	get_node("VBoxContainer/ChkWordImage").set_pressed(globals.see_words)
	get_node("VBoxContainer/HBoxContainer2/ChkWords1").set_pressed(globals.num_words == 1)
	get_node("VBoxContainer/HBoxContainer2/ChkWords2").set_pressed(globals.num_words == 2)
	get_node("VBoxContainer/HBoxContainer2/ChkWords3").set_pressed(globals.num_words == 3)
	get_node("VBoxContainer/HBoxContainer2/ChkWords4").set_pressed(globals.num_words == 4)
	get_node("VBoxContainer/HBoxContainer3/ChkSyllables1").set_pressed(globals.num_syllables == 1)
	get_node("VBoxContainer/HBoxContainer3/ChkSyllables2").set_pressed(globals.num_syllables == 2)
	get_node("VBoxContainer/HBoxContainer3/ChkSyllables3").set_pressed(globals.num_syllables == 3)
	
	if globals.valid_letters:
		for chk in get_node("VBoxContainer/GrdLetters").get_children():
			if chk.text in globals.valid_letters:
				chk.set_pressed(true)
		get_node("VBoxContainer/ChkLetters").set_pressed(true)
		get_node("VBoxContainer/GrdLetters").show()
	else:
		get_node("VBoxContainer/ChkLetters").set_pressed(false)
		get_node("VBoxContainer/GrdLetters").hide()



func _on_ChkLetters_toggled( button_pressed ):
	if button_pressed:
		get_node("VBoxContainer/GrdLetters").show()
	else:
		get_node("VBoxContainer/GrdLetters").hide()


func _on_BtnSave_pressed():
	globals.see_words = get_node("VBoxContainer/ChkWordImage").pressed
	globals.valid_letters = []
	
	if get_node("VBoxContainer/ChkLetters").is_pressed():	
		for chk in get_node("VBoxContainer/GrdLetters").get_children():
			if chk.is_pressed():
				globals.valid_letters.append(chk.get_text())
				
	globals.save_game()
	get_tree().change_scene("res://MainMenu.tscn")


func _on_ChkFewLetters_pressed():
	var pressed = get_node("VBoxContainer/HBoxContainer/ChkFewLetters").pressed
	get_node("VBoxContainer/HBoxContainer/ChkAllLetters").set_pressed(!pressed)
	globals.all_alphabet = false


func _on_ChkAllLetters_pressed():
	var pressed = get_node("VBoxContainer/HBoxContainer/ChkAllLetters").pressed
	get_node("VBoxContainer/HBoxContainer/ChkFewLetters").set_pressed(!pressed)
	globals.all_alphabet = true
	



func _on_ChkWords_pressed(num):
	globals.num_words = num
	var button = get_node("VBoxContainer/HBoxContainer2/ChkWords"+str(num))
	var pressed = button.pressed
	if (pressed):		
		get_node("VBoxContainer/HBoxContainer2/ChkWords1").set_pressed(false)
		get_node("VBoxContainer/HBoxContainer2/ChkWords2").set_pressed(false)
		get_node("VBoxContainer/HBoxContainer2/ChkWords3").set_pressed(false)
		get_node("VBoxContainer/HBoxContainer2/ChkWords4").set_pressed(false)
	button.set_pressed(true)


func _on_ChkSyllables_pressed(num):
	globals.num_syllables = num
	var button = get_node("VBoxContainer/HBoxContainer3/ChkSyllables"+str(num))
	var pressed = button.pressed
	if (pressed):		
		get_node("VBoxContainer/HBoxContainer3/ChkSyllables1").set_pressed(false)
		get_node("VBoxContainer/HBoxContainer3/ChkSyllables2").set_pressed(false)
		get_node("VBoxContainer/HBoxContainer3/ChkSyllables3").set_pressed(false)
	button.set_pressed(true)
