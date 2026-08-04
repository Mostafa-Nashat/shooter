class_name SelectiveFrag
extends Frag

@export var player_freindly: bool = false

func ready() -> void:
	hitbox.set_collision_mask_value(1, player_freindly)
	hitbox.set_collision_mask_value(2, !player_freindly)
