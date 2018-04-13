extends Button

var letter
var simple_letter

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_letter(l):
	letter = l
	simple_letter = l
	if l == "á":
		simple_letter = "a"
	if l == "é":
		simple_letter = "e"
	if l == "í":
		simple_letter = "i"
	if l == "ó":
		simple_letter = "o"
	if l == "ú":
		simple_letter = "u"
	
func mark_as_correct():
	get_node("ColorRect").color = Color(0, 1, 0, 1)
	get_node("ColorRect/Label").set_text(letter)
	
func mark_as_incorrect():
	get_node("ColorRect").color = Color(1, 0, 0, 1)
	
func mark_as_current():
	get_node("ColorRect").color = Color(1, 1, 1, 1)
	
