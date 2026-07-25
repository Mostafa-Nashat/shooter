class_name BlockResult
extends Result

@export var block: BlockData

func apply(player: Player) -> void:
	player.blocks.append(block)
