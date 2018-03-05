extends Node2D

var can_drag = true
var drag = false
var main_screen
var letter
var original_x
var original_y
var original_z

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	can_drag = true

func _process(delta):
	if drag:
		var mpos = get_viewport().get_mouse_position()

		self.position.x = mpos.x - 50
		self.position.y = mpos.y - 50
	
func set_main_screen(screen):
	main_screen = screen

func set_letter(l):
	letter = l
	get_node("TextureRect/Label").set_text(letter)
	
				
func _start_drag():
	if can_drag and main_screen.mode == main_screen.MODE_PLAYER:
		drag = true
		original_x = position.x
		original_y = position.y
		original_z = z_index
		z_index = 1000
	
func _stop_drag():
	if can_drag and main_screen.mode == main_screen.MODE_PLAYER:
		drag = false
		main_screen.check_letter(self)
	


func _on_TextureRect_gui_input( ev ):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				_start_drag()
			else:
				_stop_drag()
			
func mark_as_correct():
	can_drag = false
	get_node("TextureRect/ColorRect").color = Color(0, 1, 0, 1)
	get_node("TextureRect/ColorRect").show()
	z_index = original_z

func mark_as_incorrect():
	get_node("TextureRect/ColorRect").color = Color(1, 0, 0, 1)
	get_node("TextureRect/ColorRect").show()
	
func unmark():
	get_node("TextureRect/ColorRect").hide()
	z_index = original_z
	
	
