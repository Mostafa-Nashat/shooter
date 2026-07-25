class_name GunResult
extends Result

@export var gun: Gun_data

func apply(player: Player) -> void:
	player.gun.gun = gun
	print(player.gun.gun.sprite.resource_path)
	player.gun.update()
