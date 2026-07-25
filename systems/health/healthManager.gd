class_name HealthManager
extends Node

@export var health: float
@export var max_health: float

signal died

func set_health_to_max() -> void:
	health = max_health

func set_health(new_health: int) -> void:
	health = new_health
	health = clampf(health, 0, max_health)

func get_health() -> float:
	return health

func damage(hitpoints: float):
	health -= hitpoints
	if health <= 0:
		died.emit()
