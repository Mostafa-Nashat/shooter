class_name HealthResult
extends Result

@export var health: int

func apply(player: Player) -> void:
	player.health.set_health_to_max()

func craftable(player: Player) -> bool:
	if player.health.health >= player.health.max_health:
		return false
	return true
