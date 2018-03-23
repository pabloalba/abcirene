extends Node2D
var letter

func set_letter(l):
	letter = l
	get_node("Label").set_text(l)

func mark_as_correct():
	get_node("ColorRect").color = Color(0, 1, 0, 1)
	get_node("Label").show()