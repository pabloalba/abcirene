extends Node

var see_words = true
var num_words = 1
var num_syllables = 1
var all_alphabet = false
var valid_letters = []

var words_mslcp_enabled = true
var words_tjzr_enabled = false
var words_nbvfh_enabled = false
var words_dgllchr_enabled = false
var words_nyx_enabled = false
var words_quceci_enabled = false
var words_pluri_enabled = false
var words_mixed_enabled = false
var words_inverse_enabled = false
var words_locked_enabled = false
var words_complex_enabled = false



	
func load_game():
	#TODO
	return
	var F = File.new() # We initialize the File class
	var D = Directory.new() # and the Directory class
	if D.dir_exists("user://save"): # Check if the folder 'save' exists before moving on
		if F.open(str("user://save/abcirene.save"), File.READ_WRITE) == OK: # If the opening of the save file returns OK
			var temp_d # we create a temporary var to hold the contents of the save file
			temp_d = F.get_var() # we get the contents of the save file and store it on TEMP_D
			globals.see_words = temp_d["see_words"]
			globals.num_words = temp_d["num_words"]
			globals.num_syllables = temp_d["num_syllables"]
			globals.all_alphabet = temp_d["all_alphabet"]
			globals.valid_letters = temp_d["valid_letters"]
			return
		else: # In case the opening of the save file doesn't give an OK, we create a save file
			print("save file doesn't exist, creating one") 
			save_game() 
	else: # If the folder doesn't exist, we create one...
		D.make_dir("user://save")
		save_game() # and we create the save file using the save_game function

func save_game():
	#TODO
	return
	var current_save_game = {
		"see_words": globals.see_words,
		"num_words": globals.num_words,
		"num_syllables": globals.num_syllables,
		"all_alphabet": globals.all_alphabet,
		"valid_letters": globals.valid_letters
	}
	var F = File.new()
	F.open(str("user://save/abcirene.save"), File.READ_WRITE) # we open the file
	F.store_var(current_save_game) # then we store the contents of the var save inside it
	F.close() # and we gracefully close the file :)
