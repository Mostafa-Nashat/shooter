class_name HealthResult
extends Result

@export var health: int

func apply(player: Player) -> void:
	player.health.set_health_to_max()
