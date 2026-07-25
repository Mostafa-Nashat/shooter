class_name BlockResult
extends Result

@export var block: InventoryBlockData

func apply(player: Player) -> void:
	player.blocks.append(block)
