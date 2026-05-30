class_name SaveFile
extends Resource

@export var gun: Gun_data
@export var sword: Sword_data
@export var bullet_count: int
@export var health: int
@export var frag_count: int
@export var scene: PackedScene
@export var id: int
@export var items: Array[InventoryItemData]

func update_save_file(player: Player) -> void:
	bullet_count = player.bullet_count
	frag_count = player.frag_count
	health = int(player.health.health)
	gun = player.gun.weapon
	sword = player.sword.weapon
	items = player.item_taker.inventory

func apply_save(player: Player) -> void:
	player.bullet_count = bullet_count
	player.health.set_health(health)
	player.frag_count = frag_count
	player.item_taker.inventory = items
	if gun:
		player.set_gun(gun)
	if sword:
		player.set_sword(sword)
