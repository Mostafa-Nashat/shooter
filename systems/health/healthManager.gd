class_name HealthManager
extends Node

@export var health: float

signal died

func set_health(new_health: int) -> void:
	health = new_health

func get_health() -> float:
	return health

func damage(hitpoints: float):
	health -= hitpoints
	if health <= 0:
		died.emit()
