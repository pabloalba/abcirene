extends ColorRect

const MODE_PLAYER = 0
const MODE_ANIM = 1
const words_one = ["pie", "bus","col","flan","flor","juez"]
const words_two = ["lima", "mesa", "misa", "muela",  "pomo",  "suma", "sopa", "mapa", "pipa"]
const words_three = ["martillo", "museo", "paloma", "pamela", "pomelo","amasar"]
const words_four = []
var letter_buttons = []
var alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
var drag = false
var mode = MODE_PLAYER
var letter_pos = Vector2()
var failsafe
var current_letter
var speed = 500
var word_containers = []
var spaces = []
var letters_b = []
var word_index = 0
var shuffled_words = []
var current_space_num = 0
var current_words

func _ready():	
	randomize() 
	spaces = []
	current_letter = get_node("SelectedLetter")
	word_containers.append(get_node("Word1"))	
	word_containers.append(get_node("Word2"))
	word_containers.append(get_node("Word3"))
	word_containers.append(get_node("Word4"))
	word_containers.append(get_node("Word5"))
	word_containers.append(get_node("Word6"))
	drag = false
	mode = MODE_PLAYER
	generate_words()
	restart_game()
	
	
func restart_game():
	
	for space in spaces:
			var parent = space.get_parent ()
			parent.remove_child(space)
			space.queue_free()
	spaces = []
	
	current_words = select_words()
	
	if globals.all_alphabet:
		addValidLetters(alphabet)
	else:
		var words_letters = []
		var all_words = ""
		for w in current_words:
			all_words += w
		for l in alphabet:
			if l in all_words:		
				words_letters.append(l)
		addValidLetters(words_letters)
		
	for i in range(len(current_words)):
		create_word(i,len(current_words),current_words[i])
	
	current_space_num = 0
	spaces[current_space_num].mark_as_current()


func generate_words():		
	if globals.num_syllables == 1:
		shuffled_words = shuffle_list(words_one)
	elif globals.num_syllables == 2:
		shuffled_words = shuffle_list(words_two)
	elif globals.num_syllables == 3:
		shuffled_words = shuffle_list(words_three)
	else:
		shuffled_words = shuffle_list(words_four)	
	word_index = 0
	
func select_words():			
	var w = []
	for i in range(globals.num_words):
		w.append(shuffled_words[word_index])
		word_index = (word_index + 1) % len(shuffled_words)
	return w
		
func addValidLetters(letters):	
	for l in get_node("GridContainer").get_children():
		l.set_disabled(!l.get_text() in letters)

func _process(delta):	
	if mode == MODE_ANIM:			
		failsafe -= delta
		if failsafe <=0:
			end_anim()				
			
func end_anim():
	spaces[current_space_num].mark_as_current()
	mode = MODE_PLAYER
	
func create_word(num, total, word):
	var container = word_containers[num]
	var label = container.get_node("VBoxContainer/pictures/lbl")
	var image = container.get_node("VBoxContainer/pictures/img")
	
	label.set_text(word)
	var texture = load("res://assets/img/"+word+".png")
	image.set_texture(texture)
	
	if globals.see_words:
		label.show()
	else:
		label.hide()
		
	for i in range(len(word)):
		var space = load("res://Space.tscn").instance()
		space.set_letter(word[i])
		container.get_node("VBoxContainer/letters").add_child(space)
		spaces.append(space)	
		
		
	if total == 1:
		container.set_scale(Vector2(0.8, 0.8))
		container.position.x = 440
		container.position.y = 0
	if total == 2:
		container.set_scale(Vector2(0.8, 0.8))
		if num == 0:
			container.position.x = 100
			container.position.y = 0
		else:
			container.position.x = 700
			container.position.y = 0
	if total == 3:
		container.set_scale(Vector2(0.5, 0.5))
		if num == 0:
			container.position.x = 50
			container.position.y = 100
		elif num == 1:
			container.position.x = 500
			container.position.y = 100
		else:
			container.position.x = 900
			container.position.y = 100
	if total == 4:
		container.set_scale(Vector2(0.4, 0.4))
		if num == 0:
			container.position.x = 200
			container.position.y = 0
		elif num == 1:
			container.position.x = 800
			container.position.y = 0
		elif num == 2:
			container.position.x = 200
			container.position.y = 200
		else:
			container.position.x = 800
			container.position.y = 200
	if total == 6:
		container.set_scale(Vector2(0.4, 0.4))
		if num == 0:
			container.position.x = 100
			container.position.y = 0
		elif num == 1:
			container.position.x = 550
			container.position.y = 0
		elif num == 2:
			container.position.x = 950
			container.position.y = 0
		elif num == 3:
			container.position.x = 100
			container.position.y = 200
		elif num == 4:
			container.position.x = 550
			container.position.y = 200
		elif num == 5:
			container.position.x = 950
			container.position.y = 200	
	container.show()
	
func shuffle_list(list):
	var shuffled_list = []
	var index_list = range(list.size())
	for i in range(list.size()):        
		var x = randi()%index_list.size()
		shuffled_list.append(list[x])
		index_list.remove(x)
		list.remove(x)
	return shuffled_list


func _on_ButtonBack_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_ButtonReload_pressed():
	restart_game()


func _on_letter_pressed(l):
	if mode == MODE_PLAYER and current_space_num < len(spaces):
		if spaces[current_space_num].letter == l:
			spaces[current_space_num].mark_as_correct()
			current_space_num += 1
			if current_space_num < len(spaces):
				spaces[current_space_num].mark_as_current()
		else:
			mode = MODE_ANIM
			spaces[current_space_num].mark_as_incorrect()
			failsafe = 1
			
		



func _on_img_gui_input( ev, num ):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:				
				var sfx = load("res://assets/audio/"+current_words[num-1]+".wav") 
				get_node("AudioStreamPlayer").stream = sfx
				get_node("AudioStreamPlayer").play()
