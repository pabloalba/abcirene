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
	get_node("VBoxContainer/HBoxContainer2/ChkWords6").set_pressed(globals.num_words == 6)
	
	get_node("VBoxContainer/GridGroups/ChkGroupMSLCP").set_pressed(globals.words_mslcp_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupTJZR").set_pressed(globals.words_tjzr_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupNBVFH").set_pressed(globals.words_nbvfh_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupDGLLCHR").set_pressed(globals.words_dgllchr_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupNYX").set_pressed(globals.words_nyx_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupQUCECI").set_pressed(globals.words_quceci_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupPluri").set_pressed(globals.words_pluri_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupMixed").set_pressed(globals.words_mixed_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupInverse").set_pressed(globals.words_inverse_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupLocked").set_pressed(globals.words_locked_enabled)
	get_node("VBoxContainer/GridGroups/ChkGroupComplex").set_pressed(globals.words_complex_enabled)	


func _on_ChkLetters_toggled( button_pressed ):
	if button_pressed:
		get_node("VBoxContainer/GrdLetters").show()
	else:
		get_node("VBoxContainer/GrdLetters").hide()


func _on_BtnSave_pressed():
	globals.see_words = get_node("VBoxContainer/ChkWordImage").pressed
	
	globals.words_mslcp_enabled = get_node("VBoxContainer/GridGroups/ChkGroupMSLCP").pressed
	globals.words_tjzr_enabled = get_node("VBoxContainer/GridGroups/ChkGroupTJZR").pressed
	globals.words_nbvfh_enabled = get_node("VBoxContainer/GridGroups/ChkGroupNBVFH").pressed
	globals.words_dgllchr_enabled = get_node("VBoxContainer/GridGroups/ChkGroupDGLLCHR").pressed
	globals.words_nyx_enabled = get_node("VBoxContainer/GridGroups/ChkGroupNYX").pressed
	globals.words_quceci_enabled = get_node("VBoxContainer/GridGroups/ChkGroupQUCECI").pressed
	globals.words_pluri_enabled = get_node("VBoxContainer/GridGroups/ChkGroupPluri").pressed
	globals.words_mixed_enabled = get_node("VBoxContainer/GridGroups/ChkGroupMixed").pressed
	globals.words_inverse_enabled = get_node("VBoxContainer/GridGroups/ChkGroupInverse").pressed
	globals.words_locked_enabled = get_node("VBoxContainer/GridGroups/ChkGroupLocked").pressed
	globals.words_complex_enabled = get_node("VBoxContainer/GridGroups/ChkGroupComplex").pressed
	
	
	if not globals.words_mslcp_enabled and not globals.words_tjzr_enabled and not globals.words_nbvfh_enabled and not globals.words_dgllchr_enabled and not globals.words_nyx_enabled and not globals.words_quceci_enabled and not globals.words_pluri_enabled and not globals.words_mixed_enabled and not globals.words_inverse_enabled and not globals.words_locked_enabled and not  globals.words_complex_enabled:
		globals.words_mslcp_enabled = true
		globals.words_tjzr_enabled = true
		globals.words_nbvfh_enabled = true
		globals.words_dgllchr_enabled = true
		globals.words_nyx_enabled = true
		globals.words_quceci_enabled = true
		globals.words_pluri_enabled = true
		globals.words_mixed_enabled = true
		globals.words_inverse_enabled = true
		globals.words_locked_enabled = true
		globals.words_complex_enabled = true
	
					
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


