extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var group = [get_node("PalabrasContainer/CtrlWordsOnlyLetters"), get_node("PalabrasContainer/CtrlWordsAllLetters")]
	for item in group:
		item.set_group(group)

	group = [get_node("PalabrasContainer/CtrlWordsOneWord"), get_node("PalabrasContainer/CtrlWordsTwoWords"), get_node("PalabrasContainer/CtrlWordsThreeWords"), get_node("PalabrasContainer/CtrlWordsFourWords"), get_node("PalabrasContainer/CtrlWordsSixWords")]
	for item in group:
		item.set_group(group)		
	
	group = [get_node("FrasesContainer/CtrlPhrasesOnlyLetters"), get_node("FrasesContainer/CtrlPhrasesAllLetters")]
	for item in group:
		item.set_group(group)
	
	
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ButtonHome_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _select_section(num):
	get_node("PalabrasSettingSelected").set_visible(false)
	get_node("FrasesSettingSelected").set_visible(false)
	get_node("EstadisticasSettingSelected").set_visible(false)
	get_node("PalabrasContainer").set_visible(false)
	get_node("FrasesContainer").set_visible(false)
	get_node("EstadisticasContainer").set_visible(false)
	
	if (num == 0):
		get_node("PalabrasSettingSelected").set_visible(true)
		get_node("PalabrasContainer").set_visible(true)
	if (num == 1):
		get_node("FrasesSettingSelected").set_visible(true)
		get_node("FrasesContainer").set_visible(true)
	if (num == 2):
		get_node("EstadisticasSettingSelected").set_visible(true)
		get_node("EstadisticasContainer").set_visible(true)
	

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

