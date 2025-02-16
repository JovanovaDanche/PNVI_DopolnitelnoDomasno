extends Camera3D

@export var target: Node3D  
@export var follow_speed: float = 5.0
@export var camera_offset: Vector3 = Vector3(0, 10, -12)
@export var ray_cast: RayCast3D  

var base_y: float  
var raised_y: float  
var current_y: float  
var base_rotation: float  
var raised_rotation: float  
var current_rotation: float  

func _ready():
	if target:
		base_y = camera_offset.y      
		raised_y = base_y + 5.0        
		current_y = base_y  

		base_rotation = -10.0          
		raised_rotation = -30.0       
		current_rotation = base_rotation

func _process(delta):
	if target:
		var target_position = target.global_transform.origin + camera_offset

		# Проверка дали има судир со ѕид
		if ray_cast and ray_cast.is_colliding():
			current_y = lerp(current_y, raised_y, follow_speed * delta)  #da se podigne ako im dzid
			current_rotation = lerp(current_rotation, base_rotation, follow_speed * delta) 
		else:
			var distance_from_center = target.global_transform.origin.distance_to(Vector3(0, target.global_transform.origin.y, 0))
			var max_distance = 10.0  

			var height_factor = clamp((distance_from_center / max_distance), 0.3, 1.0)
			current_y = lerp(current_y, base_y * height_factor, follow_speed * delta)  # Da se spusti koga nema dzid
			current_rotation = lerp(current_rotation, raised_rotation, follow_speed * delta)  # Da gleda ponagore koga e vo sredina

	
		target_position.y = current_y
		global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)

	
		rotation_degrees.x = current_rotation

		#da gleda vo igrachot
		look_at(Vector3(target.global_transform.origin.x, target.global_transform.origin.y + 2, target.global_transform.origin.z))
