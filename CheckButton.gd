extends Control

var texture_selected = preload("res://assets/img/button_selected.png")
var texture_unselected = preload("res://assets/img/button_unselected.png")
var current_state = false
var group = []

func _ready():
	set_text(get_tooltip())
	
func set_group(g):
	group = g

func unselect_group():
	for item in group:
		item.set_selected(false)

func set_selected(state):
	if state:
		get_node("TextureRect").set_texture(texture_selected)
	else:
		get_node("TextureRect").set_texture(texture_unselected)

	current_state = state
	
func set_text(text):
	get_node("TextureRect/RichTextLabel").set_bbcode(text)

func _on_TextureRect_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				if group:
					if current_state:
						# No unselect on groups
						return
					else:
						unselect_group()
				set_selected(not current_state)



func _on_RichTextLabel_gui_input(ev):
	_on_TextureRect_gui_input(ev)
