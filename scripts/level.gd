extends Node3D

@onready var end_screen = $EndScreen
@onready var timer = $Timer
@onready var timer_label = $Control/TimeLabel 
@onready var countdown_sound = $AudioTimer
@onready var treasure_sound = $AudioTreasure

@export var total_gold: int = 5  
@export var total_chests: int = 5  
@export var total_coins: int = 5  

var collected_gold: int = 0  
var collected_chests: int = 0  
var collected_coins: int = 0  

var should_play_sound = false  
var game_over = false 

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	countdown_sound.finished.connect(_on_sound_finished)  
	timer.start()
	update_timer_label()

func _process(delta):
	update_timer_label()  

	if int(timer.time_left) == 10 and not should_play_sound:
		should_play_sound = true
		countdown_sound.play()

func _on_sound_finished():
	if should_play_sound and int(timer.time_left) > 0:
		countdown_sound.play()

func update_timer_label():
	var time_left = int(timer.time_left)  
	timer_label.text = "Time left: " + str(time_left) + "s"  

func _on_timer_timeout():
	if not game_over: 
		stop_all_sounds()
		should_play_sound = false  
		end_screen.show_game_over(false) 

func _on_coin_collected() -> void:
	collected_coins += 1
	play_treasure_sound()
	check_win_condition()

func _on_chest_collected() -> void:
	collected_chests += 1
	play_treasure_sound()
	check_win_condition()

func _on_gold_collected() -> void:
	collected_gold += 1
	play_treasure_sound()
	check_win_condition()

func play_treasure_sound():
	if treasure_sound:
		treasure_sound.play()

func check_win_condition() -> void:
	print("Checking win condition:", collected_gold, collected_chests, collected_coins)
	if collected_gold >= total_gold and collected_chests >= total_chests and collected_coins >= total_coins:
		stop_all_sounds()
		game_over = true  
		treasure_sound.play()
		await get_tree().create_timer(1.0).timeout
		end_screen.show_game_over(true)

func stop_all_sounds():
	countdown_sound.stop()
	treasure_sound.stop()
