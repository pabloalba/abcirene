extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var words = ["amasar", "lima", "mesa", "misa", "muela",  "museo",  "paloma",  "pamela",  "pomelo",  "pomo",  "suma"]
var spaces = []
var mode
var incorrect_letter
var speed = 500

const MODE_PLAYER = 0
const MODE_ANIM = 1

var letter_buttons = []
var current_word = ""
var word_index = 0
var shuffled_words
var failsafe

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	shuffled_words = shuffle_list(words)
	word_index = 0
	new_word()
	
	
func new_word():
	for l in spaces:
		remove_child(l)
		
	for l in letter_buttons:
		remove_child(l)
		
	spaces = []
	letter_buttons = []
	
	word_index = (word_index + 1) % len(shuffled_words)
	
	load_word(shuffled_words[word_index])	
	mode = MODE_PLAYER
	

func _process(delta):
	if mode == MODE_ANIM:				
		if incorrect_letter == null:
			mode = MODE_PLAYER
		else:
			failsafe -= delta
			if failsafe <=0:
				incorrect_letter.unmark()
				mode = MODE_PLAYER
			else:
				move_incorrect_letter(delta)

func load_word(word):
	current_word = word
	get_node("VBoxContainer/Word").set_text(word)	
	var inc = 105
	var x = (720 - (inc * len(word))) / 2
	var letters = shuffle_word(word)
	var texture = load("res://assets/img/"+word+".png")
	get_node("VBoxContainer/HBoxContainer/WordImage").set_texture(texture)
	
	for i in range(len(word)):
		var space = load("res://LetterSpace.tscn").instance()
		space.position.x = x
		space.position.y = 750
		space.set_letter(word[i])
		add_child(space)
		spaces.append(space)
		x += inc
		
	x = (720 - (inc * len(word))) / 2
	for i in range(len(word)):		
		var letter = load("res://LetterButton.tscn").instance()
		letter.set_main_screen(self)
		letter.set_letter(letters[i])
		letter_buttons.append(letter)
		letter.position.x = x
		letter.position.y = 950
		x += inc
		
		add_child(letter)
		
		
func check_letter(letter_button):
	var ok = false
	for space in spaces:
		if not ok and (abs(space.position.x - letter_button.position.x) < 70) and (abs(space.position.y - letter_button.position.y) < 70):
			if space.letter == letter_button.letter:
				letter_button.position.x = space.position.x
				letter_button.position.y = space.position.y
				letter_button.mark_as_correct()
				ok = true
				
	if not ok:
		mode = MODE_ANIM
		failsafe = 3
		letter_button.mark_as_incorrect()
		incorrect_letter = letter_button
		
				
func move_incorrect_letter(delta):
	var end_x = false
	var end_y = false
	if abs(incorrect_letter.position.x - incorrect_letter.original_x) < 10:
		incorrect_letter.position.x = incorrect_letter.original_x
		end_x = true
	elif incorrect_letter.position.x > incorrect_letter.original_x:
		incorrect_letter.position.x -= speed * delta
	else:
		incorrect_letter.position.x += speed * delta
		
	if abs(incorrect_letter.position.y - incorrect_letter.original_y) < 10:
		incorrect_letter.position.y = incorrect_letter.original_y
		end_y = true
	elif incorrect_letter.position.y > incorrect_letter.original_y:
		incorrect_letter.position.y -= speed * delta
	else:
		incorrect_letter.position.y += speed * delta
		
	if end_x and end_y:
		incorrect_letter.unmark()
		mode = MODE_PLAYER
		
	
		
	
func shuffle_word(word):	
	var list = []
	for i in range(len(word)):
		list.append(word[i])
	return shuffle_list(list)

func shuffle_list(list):
	var shuffled_list = []
	var index_list = range(list.size())
	for i in range(list.size()):        
		var x = randi()%index_list.size()
		shuffled_list.append(list[x])
		index_list.remove(x)
		list.remove(x)
	return shuffled_list

func _on_Button_pressed():
	new_word()
