class_name Sword_data
extends  Weapon_data

@export var sword_shape: Shape2D
@export_range(30, 120, 1, "or_greater", "or_less", "prefer_slider") var sword_swing_size: float = 60
@export var damage: int = 1
@export var cooldown: float = 0.5
