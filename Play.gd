extends ColorRect

const MODE_PLAYER = 0
const MODE_ANIM = 1
const MODE_SUCCESS = 2
const MIN_TIME_KEYBOARD = 0.5
# "pie", "pisa",
var words_mslcp = ["mesa", "mula", "casa", "cole", "oso", "mamá", "papá", "pupa", "pala", "polo", "sopa", "copa", "pico", "ola", "saco", "cama", "sapo", "mapa", "come", "cola", "lupa", "peso", "pila", "púa", "mío", "cose"]
var words_tjzr = ["pato", "moto", "tomate", "pelota", "maleta", "zumo", "rosa", "ropa", "ojo", "caja", "perro", "carro", "lazo", "pozo", "taza", "rata", "pijama", "tío", "río", "patata", "zapato", "rojo", "moja"]
var words_nbvfh = ["vaso", "vaca", "bota", "boca", "foca", "feo", "fila", "café", "vino", "pino", "nata", "rana", "sofá", "camino", "luna", "lana", "piano", "vela", "fuma", "oveja", "abeja", "humo", "búho", "hoja", "hielo", "cohete"]
# "hora",
var words_dgllchr = ["nido", "llave", "valla", "gato", "goma", "gusano", "caballo", "cara", "pirata", "llora", "tira", "mago", "dedo", "dado", "codo", "gallina", "coche", "leche", "chino", "chupete", "ocho", "oro", "ducha", "moda", "paga", "médico", "madera"]
var words_nyx = ["piña", "caña", "niña", "rayo", "payaso", "taxi", "boxeo", "baño", "yema", "cabaña", "araña"]
var words_quceci = ["queso", "quema", "raqueta", "quita", "pequeño", "máquina", "cine", "cena", "cereza", "cero", "maceta", "cielo"]
var words_pluri = ["caramelo", "mariposa", "gasolina", "palomitas", "bocadillo", "amapola", "lavadora", "mecánico", "marinero"]
var words_mixed = ["sol", "pez", "luz", "mar", "sal", "dos", "azul", "pan", "melón", "papel", "lápiz", "comer", "manos", "salta", "corta", "barco", "canta", "pistola", "mosca", "soldado", "montaña", "castillo", "martillo", "circo", "pantalón", "banco", "calza", "multa", "perdido"]
var words_inverse = ["espejo", "espada", "isla", "arma", "alto", "astuto", "ancho", "espina", "escudo", "asco", "antes", "indio"]
var words_locked = ["plato", "pluma", "flecha", "flor", "globo", "clavo", "clase", "bruja", "tripa", "fresa", "grúa", "brazo", "fruta", "sobre", "tigre", "sopla", "dobla", "abre", "otro"]
# "cresta", "frente", "presta"
var words_complex = ["triste", "fresco", "plástico", "brusco", "trasto", "blanco", "planta"]
var phrases = [ "casi la pilla", "dame la mano", "dame zumo de uva", "me como la sopa yo solo", "me duele la mano", "mi mono me mola", "mira esa vaca rosa", "no me da la gana", "no veo nada", "pásame el pan", "se ha ido mi loro", "toma el tomate", "tócame la cabeza", "¿me la pelas?", "échame leche","mira la foto de mi perro"]
var letters_font = load("res://font_escolar_112.tres")
var aplause = load("res://assets/audio/aplause.ogg")

var letter_buttons = []
var alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
var full_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z","á","é","í","ó","ú"]
var drag = false
var mode = MODE_PLAYER
var letter_pos = Vector2()
var failsafe
var speed = 500
var word_containers = []
var spaces = []
var letters_b = []
var word_index = 0
var shuffled_words = []
var current_space_num = 0
var current_words
var current_word_num
var words_letters = []
var time_keyboard = 0
var last_key = null

func _ready():
	if globals.settings["settings"]["rotate"]:
		get_node("Camera2D").rotation_degrees = 180
	else:
		get_node("Camera2D").rotation_degrees = 0
	words_locked.sort()
	#print (words_locked)
	randomize()
	if globals.play_word:
		globals.caps = globals.settings["words"]["caps"]
		globals.all_alphabet = globals.settings["words"]["all_alphabet"]
		globals.see_words = globals.settings["words"]["see_words"]
		globals.num_words = globals.settings["words"]["num_words"]
		globals.locution = globals.settings["words"]["locution"]
		globals.sound_win = globals.settings["words"]["sound_win"]
	else:
		globals.caps = globals.settings["phrases"]["caps"]
		globals.all_alphabet = globals.settings["phrases"]["all_alphabet"]
		globals.see_words = globals.settings["phrases"]["see_phrases"]
		globals.num_words = 1
		globals.locution = globals.settings["phrases"]["locution"]
		globals.sound_win = globals.settings["phrases"]["sound_win"]

	upper_control()
	spaces = []
	word_containers.append(get_node("Word1"))
	word_containers.append(get_node("Word2"))
	word_containers.append(get_node("Word3"))
	word_containers.append(get_node("Word4"))
	word_containers.append(get_node("Word5"))
	word_containers.append(get_node("Word6"))
	word_containers.append(get_node("Phrase"))
	drag = false
	mode = MODE_PLAYER
	last_key = null
	time_keyboard = 0
	generate_words()
	restart_game()

func upper_control():
	for node in get_node("GridContainer").get_children():
		node.get_node("Label").uppercase = globals.caps
		if globals.caps:
			node.get_node("Label").set_position(Vector2(0,5))
		else:
			node.get_node("Label").set_position(Vector2(0,-10))

func restart_game():
	for space in spaces:
		if space != null:
			var parent = space.get_parent ()
			parent.remove_child(space)
			space.queue_free()
	spaces = []

	for lc in ["Word1", "Word2", "Word3", "Word4", "Word5", "Word6", "Phrase"]:
		for node in get_node(lc + "/VBoxContainer/letters").get_children():
			get_node("Phrase/VBoxContainer/letters").remove_child(node)


	current_words = select_words()
	current_word_num = 0

	if globals.all_alphabet:
		addValidLetters(alphabet)
	else:
		words_letters = []
		var all_words = ""
		for w in current_words:
			all_words += w
		for l in full_alphabet:
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

	for container in word_containers:
		container.position.y = 10000

	if globals.play_word:
		for i in range(len(current_words)):
			create_word(i,len(current_words),current_words[i])
	else:
		create_word(6, len(current_words), current_words[0])

	current_space_num = 0
	spaces[current_space_num].mark_as_current()


func generate_words():
	shuffled_words = shuffle_list(choose_valid_words())
	word_index = 0

func choose_valid_words():
	var w = []
	if globals.play_word:
		if globals.settings["words"]["words_mslcp_enabled"]:
			w += words_mslcp
		if globals.settings["words"]["words_tjzr_enabled"]:
			w += words_tjzr
		if globals.settings["words"]["words_nbvfh_enabled"]:
			w += words_nbvfh
		if globals.settings["words"]["words_dgllchr_enabled"]:
			w += words_dgllchr
		if globals.settings["words"]["words_nyx_enabled"]:
			w += words_nyx
		if globals.settings["words"]["words_quceci_enabled"]:
			w += words_quceci
		if globals.settings["words"]["words_pluri_enabled"]:
			w += words_pluri
		if globals.settings["words"]["words_mixed_enabled"]:
			w += words_mixed
		if globals.settings["words"]["words_inverse_enabled"]:
			w += words_inverse
		if globals.settings["words"]["words_locked_enabled"]:
			w += words_locked
		if globals.settings["words"]["words_complex_enabled"]:
			w += words_complex
	else:
		w += phrases

	return w

func select_words():

	var w = []
	for i in range(globals.num_words):
		w.append(shuffled_words[word_index])
		word_index = (word_index + 1) % len(shuffled_words)
	return w

func addValidLetters(letters):
	for l in get_node("GridContainer").get_children():
		if (l.get_node("Label").get_text() in letters):
			l.get_node("Label").set("custom_colors/font_color", "#FFFFFF")
		else:
			l.get_node("Label").set("custom_colors/font_color", "#807f85")

func _process(delta):
	time_keyboard += delta
	if mode == MODE_ANIM:
		failsafe -= delta
		if failsafe <=0:
			end_anim()
	if mode == MODE_SUCCESS:
		failsafe -= delta
		if failsafe <=0:
			end_success()

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
	safe_name = safe_name.replace(" ","_")
	safe_name = safe_name.replace("¿","")
	safe_name = safe_name.replace("?","")
	return safe_name


func create_word(num, total, word):
	var safe_name = safe_word(word)
	var container = word_containers[num]
	var image
	var texture
	var label
	if globals.play_word:
		image = container.get_node("VBoxContainer/pictures/img")
		texture = load("res://assets/img/words/"+safe_name+".png")
		label = container.get_node("VBoxContainer/pictures/lbl")
	else:
		image = container.get_node("VBoxContainer/img")
		texture = load("res://assets/img/phrases/"+safe_name+".png")
		total = -1
		label = container.get_node("VBoxContainer/lbl")

	image.set_texture(texture)

	if globals.see_words:
		label.uppercase = globals.caps
		label.set_text(word)
		label.show()
	else:
		label.hide()

	for i in range(len(word)):
		if word[i] == ' ':
			var l = Label.new()
			l.set_text("          ")
			container.get_node("VBoxContainer/letters").add_child(l)
		elif word[i] == '¿' or word[i] == '?':
			var l = Label.new()
			l.set_text(word[i])
			l.add_color_override("font_color", Color(0,0,0))
			l.add_font_override("font", letters_font)
			container.get_node("VBoxContainer/letters").add_child(l)
		else:
			var space = load("res://WordLetter.tscn").instance()
			space.set_letter(word[i])
			container.get_node("VBoxContainer/letters").add_child(space)
			spaces.append(space)

	spaces.append(null)


	if total == 1:
		container.set_scale(Vector2(0.8, 0.8))
		container.position.x = 0
		container.position.y = 60
		container.get_node("VBoxContainer").rect_size.x = 1280 / 0.8
	if total == 2:
		container.set_scale(Vector2(0.57, 0.57))
		if num == 0:
			container.position.x = 0
			container.position.y = 60
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.57
		else:
			container.position.x = 640
			container.position.y = 60
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.57
	if total == 3:
		container.set_scale(Vector2(0.4, 0.4))
		if num == 0:
			container.position.x = 0
			container.position.y = 115
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.4 + 50
		elif num == 1:
			container.position.x = 450
			container.position.y = 115
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.4 + 50
		else:
			container.position.x = 852
			container.position.y = 115
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.4 + 50
	if total == 4:
		container.set_scale(Vector2(0.4, 0.4))
		if num == 0:
			container.position.x = 0
			container.position.y = 70
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.4 + 100
		elif num == 1:
			container.position.x = 640
			container.position.y = 70
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.4 + 100
		elif num == 2:
			container.position.x = 0
			container.position.y = 230
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.4 + 100
		else:
			container.position.x = 640
			container.position.y = 230
			container.get_node("VBoxContainer").rect_size.x = 640 / 0.4 + 100
	if total == 6:
		container.set_scale(Vector2(0.35, 0.35))
		if num == 0:
			container.position.x = 0
			container.position.y = 80
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
		elif num == 1:
			container.position.x = 450
			container.position.y = 80
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
		elif num == 2:
			container.position.x = 852
			container.position.y = 80
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
		elif num == 3:
			container.position.x = 0
			container.position.y = 230
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
		elif num == 4:
			container.position.x = 450
			container.position.y = 230
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
		elif num == 5:
			container.position.x = 852
			container.position.y = 230
			container.get_node("VBoxContainer").rect_size.x = 426 / 0.35 + 50
	if total == -1: # Phrase
		container.set_scale(Vector2(0.55, 0.55))
		container.position.x = 0
		if globals.see_words:
			container.position.y = 60
		else:
			container.position.y = 110
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
	if mode == MODE_PLAYER:
		get_tree().change_scene("res://MainMenu.tscn")


func _on_ButtonReload_pressed():
	if mode == MODE_PLAYER:
		restart_game()


func _on_letter_pressed(l):
	if mode == MODE_PLAYER and current_space_num < len(spaces):
		if spaces[current_space_num].simple_letter == l:
			spaces[current_space_num].mark_as_correct()
			current_space_num += 1
			if current_space_num < len(spaces):
				if (spaces[current_space_num] == null):
					# word end
					start_success()
				else:
					spaces[current_space_num].mark_as_current()

		else:
			mode = MODE_ANIM
			spaces[current_space_num].mark_as_incorrect()
			save_statistics(spaces[current_space_num].simple_letter)
			failsafe = 1

func save_statistics(letter):
	var current = 0
	if globals.settings["statistics"]["letters"].has(letter):
		current = globals.settings["statistics"]["letters"][letter]
	globals.settings["statistics"]["letters"][letter] = current + 1

	var word = current_words[current_word_num]
	current = 0
	if globals.play_word:
		if globals.settings["statistics"]["words"].has(word):
				current = globals.settings["statistics"]["words"][word]
		globals.settings["statistics"]["words"][word] = current + 1
	else:
		if globals.settings["statistics"]["phrases"].has(word):
				current = globals.settings["statistics"]["phrases"][word]
		globals.settings["statistics"]["phrases"][word] = current + 1

	globals.save_game()

func start_success():
	var safe_name = safe_word(current_words[current_word_num])
	if globals.locution:
		_play_word(safe_name, globals.sound_win)
	elif globals.sound_win:
		play_aplause(null)

	mode = MODE_SUCCESS
	failsafe = 1
	var i = current_space_num -1
	while i >= 0 and spaces[i] != null:
		spaces[i].mark_as_success()
		i -= 1

func end_success():
	var i = current_space_num -1
	while i >= 0 and spaces[i] != null:
		spaces[i].mark_as_correct()
		i -= 1
	current_space_num += 1
	if current_space_num < len(spaces):
		spaces[current_space_num].mark_as_current()
		current_word_num += 1
	mode = MODE_PLAYER


func _play_word(safe_name, play_aplause):
	var music_player = get_node("AudioStreamPlayer")
	var sfx = load("res://assets/audio/" + safe_name + ".ogg")
	sfx.set_loop(false)
	music_player.stream = sfx
	music_player.play()
	if play_aplause:
		music_player.connect("finished", self, "play_aplause", [music_player])

func play_aplause(who):
	get_node("AudioStreamPlayer").disconnect("finished", self, "play_aplause")
	get_node("AudioStreamPlayer").stream = aplause
	get_node("AudioStreamPlayer").play()


func _on_img_gui_input( ev, num ):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				var safe_name = safe_word(current_words[num-1])
				_play_word(safe_name, false)



func _on_Letter_gui_input(ev, l):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				if globals.settings["words"]["all_alphabet"] or l in words_letters:
					_on_letter_pressed(l)

func _input(ev):
	if ev is InputEventKey:
		var l = char(ev.unicode).to_lower()
		if l != last_key or time_keyboard > MIN_TIME_KEYBOARD:
			time_keyboard = 0
			last_key = l
			_on_letter_pressed(l)



func _on_ButtonPrev_pressed():
	if mode == MODE_PLAYER:
		word_index -= 2
		restart_game()
