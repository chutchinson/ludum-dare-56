extends Camera3D

@export var tracking_speed := 2.0
@export var target: Fighter

var _last_position := Vector3.ZERO

func _physics_process(delta: float) -> void:
	if target == null: return
	
	var target_z = target.global_position.z
	var camera_z = global_position.z
	
	if abs(target_z - camera_z) < 2.0:
		return
		
	var predicted_position := target.global_position
	predicted_position.y = position.y
	predicted_position.x = position.x
	position = position.move_toward(predicted_position, delta * tracking_speed)
	
	pass
