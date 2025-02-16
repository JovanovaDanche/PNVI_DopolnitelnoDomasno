extends Node3D
@onready var end_screen = $EndScreen
@onready var timer = $Timer
@onready var timer_label = $Control/TimeLabel 

@export var total_gold: int = 5  
@export var total_chests: int = 5  
@export var total_coins: int = 5  

var collected_gold: int = 0  
var collected_chests: int = 0  
var collected_coins: int = 0  

	
func _on_coin_collected() -> void:
	collected_coins += 1
	check_win_condition()

func _on_chest_collected() -> void:
	collected_chests += 1
	check_win_condition()

func _on_gold_collected() -> void:
	collected_gold += 1
	check_win_condition()

func check_win_condition() -> void:
	print("Checking win condition:", collected_gold, collected_chests, collected_coins)
	if collected_gold >= total_gold and collected_chests >= total_chests and collected_coins >= total_coins:
		print("Win condition met!")
		end_screen.show_game_over(true)  

		

func show_win_screen() -> void:
	load("res://endScreen.tscn").instantiate()
	get_tree().current_scene.add_child(end_screen)
	end_screen.visible = true
	
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	update_timer_label()
func _process(delta):
	update_timer_label()  
	
func update_timer_label():
	var time_left = int(timer.time_left)  
	timer_label.text = "Time left: " + str(time_left) + "s"  

func _on_timer_timeout():
	end_screen.show_game_over(false) 
