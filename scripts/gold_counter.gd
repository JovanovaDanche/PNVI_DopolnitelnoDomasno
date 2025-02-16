extends Label

var gold = 0

func _ready() -> void:
	text = str(gold)


func _on_gold_gold_collected() -> void:
	gold+=1
	text = str(gold)
	
