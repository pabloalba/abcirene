extends Button

var letter

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_letter(l):
	letter = l
	
func mark_as_correct():
	get_node("ColorRect").color = Color(0, 1, 0, 1)
	get_node("ColorRect/Label").set_text(letter)
	
func mark_as_incorrect():
	get_node("ColorRect").color = Color(1, 0, 0, 1)
	
func mark_as_current():
	get_node("ColorRect").color = Color(1, 1, 1, 1)
	
