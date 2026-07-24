class_name Recipe
extends Resource

@export var title: String
@export_multiline() var description: String
@export var ingredients: Array[InventoryItemData]
@export var preview: Texture2D
@export var result: Result

func craftable(player: Player) -> bool:
	for ingredient in ingredients:
		var is_craftable: bool = false
		for item in player.item_taker.inventory:
			if ingredient.data.name == item.data.name:
				is_craftable = true
		if !is_craftable:
			return false
	return true

func apply(player: Player):
	result.apply(player)
