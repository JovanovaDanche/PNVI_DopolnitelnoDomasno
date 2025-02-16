extends Label

var chest = 0



func _ready() -> void:
	text = str(chest)


func _on_chest_blender_chest_collected() -> void:
	chest+=1
	text = str(chest)
