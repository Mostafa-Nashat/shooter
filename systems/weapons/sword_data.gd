class_name Sword_data
extends  Weapon_data

@export var sword_size: Vector2
@export_range(30, 120, 1, "or_greater", "or_less", "prefer_slider") var sword_swing_size: float = 60
