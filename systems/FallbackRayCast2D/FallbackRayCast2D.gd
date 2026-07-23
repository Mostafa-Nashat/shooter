class_name FallbackRayCast2D
extends RayCast2D

@export var fallback: Node2D


func get_collision_point_or_fallback() -> Vector2:
	if is_colliding():
		return get_collision_point()
	return fallback.global_position
