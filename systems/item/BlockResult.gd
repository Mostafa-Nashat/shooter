class_name BlockResult
extends Result

@export var block: InventoryBlockData

func apply(player: Player) -> void:
	var block_resource := block.duplicate_deep()
	player.blocks.append(block_resource)
