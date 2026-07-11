class_name Health_manager
extends Node

var health: int

func set_health(new_health: int) -> void:
	health = new_health

func get_health() -> int:
	return health

func damage(damage: int) -> bool:
	health -= damage
	if health <= 0:
		return true
	return false
