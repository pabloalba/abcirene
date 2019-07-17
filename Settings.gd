extends ColorRect

class StatisticsSorter:
	static func sort(a,b):
		if a[1] > b[1]:
			return true
		return false


func _ready():
	if globals.settings["settings"]["rotate"]:
		get_node("Camera2D").rotation_degrees = 180
	else:
		get_node("Camera2D").rotation_degrees = 0
	var group = [get_node("PalabrasContainer/CtrlWordsOnlyLetters"), get_node("PalabrasContainer/CtrlWordsAllLetters")]
	for item in group:
		item.set_group(group)

	group = [get_node("PalabrasContainer/CtrlWordsNumWords1"), get_node("PalabrasContainer/CtrlWordsNumWords2"), get_node("PalabrasContainer/CtrlWordsNumWords3"), get_node("PalabrasContainer/CtrlWordsNumWords4"), get_node("PalabrasContainer/CtrlWordsNumWords6")]
	for item in group:
		item.set_group(group)		
	
	group = [get_node("FrasesContainer/CtrlPhrasesOnlyLetters"), get_node("FrasesContainer/CtrlPhrasesAllLetters")]
	for item in group:
		item.set_group(group)
		
	load_old_settings()
	load_statistics()

func load_old_settings():
	if globals.settings["words"]["all_alphabet"]:
		get_node("PalabrasContainer/CtrlWordsAllLetters").set_selected(true)
	else:
		get_node("PalabrasContainer/CtrlWordsOnlyLetters").set_selected(true)
	
	if globals.settings["words"]["see_words"]:
		get_node("PalabrasContainer/CtrlWordsSeeWords").set_selected(true)
	if globals.settings["words"]["caps"]:
		get_node("PalabrasContainer/CtrlWordsCaps").set_selected(true)
	var num_words = globals.settings["words"]["num_words"]
	get_node("PalabrasContainer/CtrlWordsNumWords"+str(num_words)).set_selected(true)
	if globals.settings["words"]["words_mslcp_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupMLSCP").set_selected(true)
	if globals.settings["words"]["words_tjzr_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupTJZR").set_selected(true)
	if globals.settings["words"]["words_nbvfh_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupNBVFH").set_selected(true)
	if globals.settings["words"]["words_dgllchr_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupDGLLCHR").set_selected(true)
	if globals.settings["words"]["words_nyx_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupNYX").set_selected(true)
	if globals.settings["words"]["words_quceci_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupQUCECI").set_selected(true)
	if globals.settings["words"]["words_pluri_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupPluri").set_selected(true)
	if globals.settings["words"]["words_mixed_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupMix").set_selected(true)
	if globals.settings["words"]["words_inverse_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupInv").set_selected(true)
	if globals.settings["words"]["words_locked_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupLocked").set_selected(true)
	if globals.settings["words"]["words_complex_enabled"]:
		get_node("PalabrasContainer/CtrlWordsGroupComp").set_selected(true)
	if globals.settings["words"]["locution"]:
		get_node("PalabrasContainer/CtrlWordsSoundLocution").set_selected(true)
	if globals.settings["words"]["sound_win"]:
		get_node("PalabrasContainer/CtrlWordsSoundWin").set_selected(true)
		
	if globals.settings["phrases"]["all_alphabet"]:
		get_node("FrasesContainer/CtrlPhrasesAllLetters").set_selected(true)
	else: 
		get_node("FrasesContainer/CtrlPhrasesOnlyLetters").set_selected(true)
	if globals.settings["phrases"]["see_phrases"]:
		get_node("FrasesContainer/CtrlPhrasesSeePhrases").set_selected(true)
	if globals.settings["phrases"]["caps"]:
		get_node("FrasesContainer/CtrlPhrasesCaps").set_selected(true)
	if globals.settings["phrases"]["locution"]:
		get_node("FrasesContainer/CtrlPhrasesLocution").set_selected(true)
	if globals.settings["phrases"]["sound_win"]:
		get_node("FrasesContainer/CtrlPhrasesSoundWin").set_selected(true)
		
	if globals.settings["settings"]["rotate"]:
		get_node("ConfiguracionContainer/CtrlRotate").set_selected(true)
		
		
#	"statistics" : {
#	}
#}



func _on_ButtonHome_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _select_section(num):
	get_node("PalabrasSettingSelected").set_visible(false)
	get_node("FrasesSettingSelected").set_visible(false)
	get_node("EstadisticasSettingSelected").set_visible(false)
	get_node("ConfiguracionSettingSelected").set_visible(false)
	get_node("PalabrasContainer").set_visible(false)
	get_node("FrasesContainer").set_visible(false)
	get_node("EstadisticasContainer").set_visible(false)
	get_node("ConfiguracionContainer").set_visible(false)
	
	if (num == 0):
		get_node("PalabrasSettingSelected").set_visible(true)
		get_node("PalabrasContainer").set_visible(true)
	if (num == 1):
		get_node("FrasesSettingSelected").set_visible(true)
		get_node("FrasesContainer").set_visible(true)
	if (num == 2):
		get_node("EstadisticasSettingSelected").set_visible(true)
		get_node("EstadisticasContainer").set_visible(true)
	if (num == 3):
		get_node("ConfiguracionSettingSelected").set_visible(true)
		get_node("ConfiguracionContainer").set_visible(true)
	

func _on_Frases_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_select_section(1)


func _on_Estadisticas_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_select_section(2)


func _on_Palabras_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_select_section(0)
				
func _on_Configuracion_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_select_section(3)


func save_settings():
	
	
	globals.settings["words"]["all_alphabet"] = get_node("PalabrasContainer/CtrlWordsAllLetters").current_state
	globals.settings["words"]["see_words"] = get_node("PalabrasContainer/CtrlWordsSeeWords").current_state
	globals.settings["words"]["caps"] = get_node("PalabrasContainer/CtrlWordsCaps").current_state
	
	if get_node("PalabrasContainer/CtrlWordsNumWords1").current_state:
		globals.settings["words"]["num_words"] = 1
	elif get_node("PalabrasContainer/CtrlWordsNumWords2").current_state:
		globals.settings["words"]["num_words"] = 2
	elif get_node("PalabrasContainer/CtrlWordsNumWords3").current_state:
		globals.settings["words"]["num_words"] = 3
	elif get_node("PalabrasContainer/CtrlWordsNumWords4").current_state:
		globals.settings["words"]["num_words"] = 4
	elif get_node("PalabrasContainer/CtrlWordsNumWords6").current_state:
		globals.settings["words"]["num_words"] = 6
		
	globals.settings["words"]["words_mslcp_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupMLSCP").current_state
	globals.settings["words"]["words_tjzr_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupTJZR").current_state
	globals.settings["words"]["words_nbvfh_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupNBVFH").current_state
	globals.settings["words"]["words_dgllchr_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupDGLLCHR").current_state
	globals.settings["words"]["words_nyx_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupNYX").current_state
	globals.settings["words"]["words_quceci_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupQUCECI").current_state
	globals.settings["words"]["words_pluri_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupPluri").current_state
	globals.settings["words"]["words_mixed_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupMix").current_state
	globals.settings["words"]["words_inverse_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupInv").current_state
	globals.settings["words"]["words_locked_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupLocked").current_state
	globals.settings["words"]["words_complex_enabled"] = get_node("PalabrasContainer/CtrlWordsGroupComp").current_state
	
	if not globals.settings["words"]["words_mslcp_enabled"] and not globals.settings["words"]["words_tjzr_enabled"] and not globals.settings["words"]["words_nbvfh_enabled"] and not globals.settings["words"]["words_dgllchr_enabled"] and not globals.settings["words"]["words_nyx_enabled"] and not globals.settings["words"]["words_quceci_enabled"] and not globals.settings["words"]["words_pluri_enabled"] and not globals.settings["words"]["words_mixed_enabled"] and not globals.settings["words"]["words_inverse_enabled"] and not globals.settings["words"]["words_locked_enabled"] and not globals.settings["words"]["words_complex_enabled"]:
		globals.settings["words"]["words_mslcp_enabled"] = true
	
	globals.settings["words"]["locution"] = get_node("PalabrasContainer/CtrlWordsSoundLocution").current_state
	globals.settings["words"]["sound_win"] = get_node("PalabrasContainer/CtrlWordsSoundWin").current_state
	
	
	globals.settings["phrases"]["all_alphabet"] = get_node("FrasesContainer/CtrlPhrasesAllLetters").current_state
	globals.settings["phrases"]["see_phrases"] = get_node("FrasesContainer/CtrlPhrasesSeePhrases").current_state
	globals.settings["phrases"]["caps"] = get_node("FrasesContainer/CtrlPhrasesCaps").current_state
	globals.settings["phrases"]["locution"] = get_node("FrasesContainer/CtrlPhrasesLocution").current_state
	globals.settings["phrases"]["sound_win"] = get_node("FrasesContainer/CtrlPhrasesSoundWin").current_state
	
	globals.settings["settings"]["rotate"] = get_node("ConfiguracionContainer/CtrlRotate").current_state
	
		
	
func load_statistics():
	# letters
	var letters = []
	for key in globals.settings["statistics"]["letters"].keys():
		letters.append([key, globals.settings["statistics"]["letters"][key]])
		
	letters.sort_custom(StatisticsSorter, "sort")
	
	# words
	var words = []
	for key in globals.settings["statistics"]["words"].keys():
		words.append([key, globals.settings["statistics"]["words"][key]])
		
	words.sort_custom(StatisticsSorter, "sort")
	
	# phrases
	var phrases = []
	for key in globals.settings["statistics"]["phrases"].keys():
		phrases.append([key, globals.settings["statistics"]["phrases"][key]])
		
	phrases.sort_custom(StatisticsSorter, "sort")
	
	
	
	var i
	for i in range(10):
		if len(letters) > i: 
			get_node("EstadisticasContainer/LblLetter"+str(i+1)).set_text(letters[i][0] + " ("+str(letters[i][1]) + ")")
		if len(words) > i: 
			get_node("EstadisticasContainer/LblWord"+str(i+1)).set_text(words[i][0] + " ("+str(words[i][1]) + ")")
		if len(phrases) > i: 
			get_node("EstadisticasContainer/LblPhrase"+str(i+1)).set_text(phrases[i][0] + " ("+str(phrases[i][1]) + ")")

func _on_SaveButton_pressed():
	save_settings()
	globals.save_game()
	_on_ButtonHome_pressed()



