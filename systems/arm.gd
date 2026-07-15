class_name Arm
extends Node2D

func look_at_target(target: Vector2, max_speed: float):
	
	var angle_to_mouse := get_angle_to(target)
	var arm_motion: float
	arm_motion = clamp(rad_to_deg(angle_to_mouse), -max_speed, max_speed)
	rotate(deg_to_rad(arm_motion))
