extends Area3D

signal coinCollected

@export var rotation_speed: float = 70.0 

func _ready():
	connect("body_entered", _on_body_entered)

func _process(delta):
	rotation_degrees.y += rotation_speed * delta  

func _on_body_entered(body):
	if body.name == "player":  
		emit_signal("coinCollected")
		get_tree().create_timer(0.1).timeout.connect(_delete_treasure) 

func _delete_treasure():
	queue_free()
