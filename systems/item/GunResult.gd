class_name GunResult
extends Result

@export var gun: Gun_data

func apply(player: Player) -> void:
	player.gun.gun = gun
	player.gun.update()

func craftable(player: Player) -> bool:
	if player.gun.gun == gun:
		return false
	return true
