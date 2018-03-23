extends Button

var letter
var play_scene

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func set_letter(l):
	letter = l
	set_text(letter)
	
func set_play_scene(scene):
	play_scene = scene

func _on_LetterB_button_down():
	play_scene.select_letter(self)


func _on_LetterB_button_up():
	play_scene.letter_up(self)
