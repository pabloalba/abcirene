extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ButtonHome_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _move_settings_selected(x):
	var cur_pos = get_node("SettingSelected").get_pos()
	cur_pos.x = x
	get_node("SettingSelected").set_pos(cur_pos)

func _on_LabelPalabras_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_move_settings_selected(140)


func _on_LabelFrases_gui_input(ev):
	print("_on_LabelFrases_gui_input")
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				print("_on_LabelFrases_gui_input")
				_move_settings_selected(340)


func _on_LabelEstadisticas_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_move_settings_selected(540)
