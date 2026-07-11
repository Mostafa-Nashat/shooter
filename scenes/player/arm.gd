extends Node2D

func look_at_mouse(max_speed: float):
	var angle_to_mouse := get_angle_to(get_global_mouse_position())
	var arm_motion: float = clamp(rad_to_deg(angle_to_mouse), -max_speed, max_speed)
	rotate(deg_to_rad(arm_motion))
	
	var angle_offset = 90
	var arm_angle := int(rad_to_deg(rotation) + angle_offset) % 360
	if arm_angle < 0:
		arm_angle = 360 + arm_angle
	if arm_angle > 180:
		scale = Vector2(1, -1)
	else:
		scale = Vector2(1, 1)

func _physics_process(_delta: float) -> void:
	look_at_mouse(20)
