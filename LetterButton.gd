extends Node2D

var letter

func _ready():
	pass


func set_letter(l):
	letter = l
	get_node("Label").set_text(letter)
	
				
			
func mark_as_correct():
	get_node("ColorRect").color = Color(0, 1, 0, 1)
	get_node("ColorRect").show()

func mark_as_incorrect():
	get_node("ColorRect").color = Color(1, 0, 0, 1)
	get_node("ColorRect").show()
	
func unmark():
	get_node("ColorRect").hide()
	
	
	
