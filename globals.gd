extends Node
const version = "1.0.0"

var see_words = true
var num_words = 1
var all_alphabet = false
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
	var save_game = File.new() # We initialize the File class
	
	if save_game.open(str("user://abcirene.save"), File.READ_WRITE) == OK: # If the opening of the save file returns OK
		var temp_d # we create a temporary var to hold the contents of the save file
		temp_d = save_game.get_var() # we get the contents of the save file and store it on TEMP_D
		save_game.close()
		
		if "version" in temp_d and temp_d["version"] == version:		
			globals.see_words = temp_d["see_words"]
			globals.num_words = temp_d["num_words"]
			globals.all_alphabet = temp_d["all_alphabet"]
			globals.words_mslcp_enabled = temp_d["words_mslcp_enabled"]
			globals.words_tjzr_enabled = temp_d["words_tjzr_enabled"]
			globals.words_nbvfh_enabled = temp_d["words_nbvfh_enabled"]
			globals.words_dgllchr_enabled = temp_d["words_dgllchr_enabled"]
			globals.words_nyx_enabled = temp_d["words_nyx_enabled"]
			globals.words_quceci_enabled = temp_d["words_quceci_enabled"]
			globals.words_pluri_enabled = temp_d["words_pluri_enabled"]
			globals.words_mixed_enabled = temp_d["words_mixed_enabled"]
			globals.words_mixed_enabled = temp_d["words_mixed_enabled"]
			globals.words_inverse_enabled = temp_d["words_inverse_enabled"]
			globals.words_locked_enabled = temp_d["words_locked_enabled"]
			globals.words_complex_enabled = temp_d["words_complex_enabled"]
		else:
			print("wrong version, creating new savegame")
			save_game()
			
	else: # In case the opening of the save file doesn't give an OK, we create a save file	
		print("save file doesn't exist, creating one") 
		save_game() 
	

func save_game():
	var current_save_game = {
		"version": globals.version,		
		"see_words": globals.see_words,
		"num_words": globals.num_words,
		"all_alphabet": globals.all_alphabet,
		"words_mslcp_enabled": globals.words_mslcp_enabled,
		"words_tjzr_enabled": globals.words_tjzr_enabled,
		"words_nbvfh_enabled": globals.words_nbvfh_enabled,
		"words_dgllchr_enabled": globals.words_dgllchr_enabled,
		"words_nyx_enabled": globals.words_nyx_enabled,
		"words_quceci_enabled": globals.words_quceci_enabled,
		"words_pluri_enabled": globals.words_pluri_enabled,
		"words_mixed_enabled": globals.words_mixed_enabled,
		"words_inverse_enabled": globals.words_inverse_enabled,
		"words_locked_enabled": globals.words_locked_enabled,
		"words_complex_enabled": globals.words_complex_enabled
	}
	var save_game = File.new()
	if save_game.open(str("user://abcirene.save"), File.WRITE) == OK: # If the opening of the save file returns OK	
		save_game.store_var(current_save_game) # then we store the contents of the var save inside it
		save_game.close() # and we gracefully close the file :)
