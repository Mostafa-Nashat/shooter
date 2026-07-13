class_name Arm
extends Node2D

func look_at_target(target: Vector2, max_speed: float, offset: float = 0):
	var angle_to_mouse := get_angle_to(target)
	var arm_motion: float = clamp(rad_to_deg(angle_to_mouse), -max_speed, max_speed)
	rotate(deg_to_rad(arm_motion))
	
	var angle_offset = 90
	var arm_angle := int(rad_to_deg(rotation) + angle_offset + offset) % 360
	if arm_angle < 0:
		arm_angle = 360 + arm_angle
	if arm_angle > 180:
		scale = Vector2(1, -1)
	else:
		scale = Vector2(1, 1)
