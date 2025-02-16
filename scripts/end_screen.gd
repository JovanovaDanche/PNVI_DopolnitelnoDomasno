extends Control  

@onready var label = $Label
@onready var restart_button = $restart_button 

func _ready():
	restart_button.pressed.connect(_restart_game)
	hide()  
	label.text = "Тест текст!"  
	var screen_size = get_viewport_rect().size
	label.position = (screen_size / 2) - (label.size / 2)
	
func show_game_over(is_won: bool):
	if is_won:
		label.text = "You won!" 
	else:
		label.text = "You lost!"
	show()
	restart_button.pressed.connect(_restart_game)

func _restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
