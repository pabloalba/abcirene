extends ColorRect

const MODE_PLAYER = 0
const MODE_ANIM = 1

var words_mslcp = ["mesa", "mula", "casa", "cole", "oso", "mamá", "papá", "pupa", "pala", "polo", "sopa", "copa", "pico", "ola", "saco", "cama", "sapo", "mapa", "come", "cola", "lupa", "peso", "pila", "pisa", "pie", "púa", "mío", "cose"]
var words_tjzr = ["pato", "moto", "tomate", "pelota", "maleta", "zumo", "rosa", "ropa", "ojo", "caja", "perro", "carro", "lazo", "pozo", "taza", "rata", "pijama", "tío", "río", "patata", "zapato", "rojo", "moja"]
var words_nbvfh = ["vaso", "vaca", "bota", "boca", "foca", "feo", "fila", "café", "vino", "pino", "nata", "rana", "sofá", "camino", "luna", "lana", "piano", "vela", "fuma", "oveja", "abeja", "humo", "búho", "hoja", "hielo", "cohete"]
var words_dgllchr = ["nido", "llave", "valla", "gato", "goma", "gusano", "caballo", "cara", "pirata", "llora", "tira", "mago", "dedo", "dado", "codo", "gallina", "coche", "leche", "chino", "chupete", "ocho", "oro", "ducha", "moda", "paga", "hora", "médico", "madera"]
var words_nyx = ["piña", "caña", "niña", "rayo", "payaso", "taxi", "boxeo", "baño", "yema", "cabaña", "araña"]
var words_quceci = ["queso", "quema", "raqueta", "quita", "pequeño", "máquina", "cine", "cena", "cereza", "cero", "maceta", "cielo"]
var words_pluri = ["caramelo", "mariposa", "gasolina", "palomitas", "bocadillo", "amapola", "lavadora", "mecánico", "marinero"]
var words_mixed = ["sol", "pez", "luz", "mar", "sal", "dos", "azul", "pan", "melón", "papel", "lápiz", "comer", "manos", "salta", "corta", "barco", "canta", "pistola", "mosca", "soldado", "montaña", "castillo", "martillo", "circo", "pantalón", "banco", "calza", "multa", "perdido"]
var words_inverse = ["espejo", "espada", "isla", "arma", "alto", "astuto", "ancho", "espina", "escudo", "asco", "antes", "indio"]
var words_locked = ["plato", "pluma", "flecha", "flor", "globo", "clavo", "clase", "bruja", "tripa", "fresa", "grúa", "brazo", "fruta", "sobre", "tigre", "sopla", "dobla", "abre", "otro"]
var words_complex = ["triste", "fresco", "plástico", "brusco", "trasto", "blanco", "planta", "cresta", "frente", "presta"]


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
				if l == "á":
					l = "a"
				if l == "é":
					l = "e"
				if l == "í":
					l = "i"
				if l == "ó":
					l = "o"
				if l == "ú":
					l = "u"
				words_letters.append(l)
		addValidLetters(words_letters)
		
	for i in range(len(current_words)):
		create_word(i,len(current_words),current_words[i])
	
	current_space_num = 0
	spaces[current_space_num].mark_as_current()


func generate_words():		
	shuffled_words = shuffle_list(choose_valid_words())
	word_index = 0
	
func choose_valid_words():
	var w = []
	if globals.words_mslcp_enabled:
		w += words_mslcp
	if globals.words_tjzr_enabled:
		w += words_tjzr
	if globals.words_nbvfh_enabled:
		w += words_nbvfh
	if globals.words_dgllchr_enabled:
		w += words_dgllchr
	if globals.words_nyx_enabled:
		w += words_nyx
	if globals.words_quceci_enabled:
		w += words_quceci
	if globals.words_pluri_enabled:
		w += words_pluri
	if globals.words_mixed_enabled:
		w += words_mixed
	if globals.words_inverse_enabled:
		w += words_inverse
	if globals.words_locked_enabled:
		w += words_locked
	if globals.words_complex_enabled:
		w += words_complex
		
	return w
	
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

func safe_word(word):
	var safe_name = word.replace("á","a")
	safe_name = safe_name.replace("é","e")
	safe_name = safe_name.replace("í","i")
	safe_name = safe_name.replace("ó","o")
	safe_name = safe_name.replace("ú","u")
	safe_name = safe_name.replace("ñ","n")
	return safe_name

	
func create_word(num, total, word):
	var container = word_containers[num]
	var label = container.get_node("VBoxContainer/pictures/lbl")
	var image = container.get_node("VBoxContainer/pictures/img")
	
	label.set_text(word)
	var safe_name = safe_word(word)
	
	var texture = load("res://assets/img/words/"+safe_name+".png")
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
		if spaces[current_space_num].simple_letter == l:
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
				var safe_name = safe_word(current_words[num-1])		
				var sfx = load("res://assets/audio/" + safe_name + ".wav") 
				get_node("AudioStreamPlayer").stream = sfx
				get_node("AudioStreamPlayer").play()
