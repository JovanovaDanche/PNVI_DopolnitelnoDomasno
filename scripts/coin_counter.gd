extends Label

var coins = 0



func _ready() -> void:
	text = str(coins)


func _on_coin_collected() -> void:
	coins+=1
	text = str(coins)
	
