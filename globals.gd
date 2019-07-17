extends Node
const version = "2.0.1"
var caps = false
var all_alphabet = false
var play_word = true
var see_words = false
var num_words = 1
var locution = true
var sound_win = true

# Default settings
var settings = {
	"version": version,
	"words": {
		"all_alphabet": false,
		"see_words": true,
		"caps": false,
		"num_words": 1,
		"words_mslcp_enabled" : true,
		"words_tjzr_enabled" : true,
		"words_nbvfh_enabled" : true,
		"words_dgllchr_enabled" : true,
		"words_nyx_enabled" : true,
		"words_quceci_enabled" : true,
		"words_pluri_enabled" : true,
		"words_mixed_enabled" : true,
		"words_inverse_enabled": true,
		"words_locked_enabled" : true,
		"words_complex_enabled": true,
		"locution": true,
		"sound_win": true
	},
	"phrases": {
		"all_alphabet": false,
		"see_phrases": true,
		"caps": false,
		"locution": true,
		"sound_win": true
	},
	"statistics" : {
		"letters": {},
		"words": {},
		"phrases": {}
	},
	"settings" : {
		"rotate": false
	}
}


func save_game():
	var save_game = File.new()
	if save_game.open(str("user://abcirene.save"), File.WRITE) == OK: # If the opening of the save file returns OK	
		save_game.store_var(globals.settings) # then we store the contents of the var save inside it
		save_game.close() # and we gracefully close the file :)

func load_game():
	var save_game = File.new() # We initialize the File class
	var loaded = false
	if save_game.open(str("user://abcirene.save"), File.READ_WRITE) == OK: # If the opening of the save file returns OK
		var temp_d # we create a temporary var to hold the contents of the save file
		temp_d = save_game.get_var() # we get the contents of the save file and store it on TEMP_D
		save_game.close()
		
		if "version" in temp_d and temp_d["version"] == version:
			globals.settings = temp_d			
			loaded = true
		if "version" in temp_d and temp_d["version"] == "2.0.0":
			globals.settings = temp_d		
			globals.settings["settings"] = {"rotate": false}
			globals.settings["version"]  = version
			loaded = true

	if not loaded:
		print("creating new savegame")
		save_game()		
	