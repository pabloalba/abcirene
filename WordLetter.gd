extends TextureRect


var text_correct = preload("res://assets/img/letter_correct.jpg")
var text_incorrect = preload("res://assets/img/letter_incorrect.jpg")
var text_success = preload("res://assets/img/letter_success.jpg")
var text_current = preload("res://assets/img/letter_current.jpg")

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
	set_texture(text_correct)
	#get_node("ColorRect").color = Color(0, 1, 0, 1)
	get_node("Label").set_text(letter)
	
func mark_as_incorrect():
	set_texture(text_incorrect)
	#get_node("ColorRect").color = Color(1, 0, 0, 1)
	
func mark_as_current():
	set_texture(text_current)
	#get_node("ColorRect").color = Color(1, 1, 1, 1)
	
func mark_as_success():
	set_texture(text_success)
	#get_node("ColorRect").color = Color(0, 1, 1, 1)