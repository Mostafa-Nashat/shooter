class_name Recipe
extends Resource

@export var title: String
@export_multiline() var description: String
@export var ingredients: Array[InventoryItemData]
@export var preview: Texture2D
@export var sound_affect: AudioStream
@export var volume: float
@export var result: Result 

func craftable(player: Player) -> bool:
	for ingredient in ingredients:
		var is_craftable: bool = false
		for item in player.item_taker.inventory:
			if ingredient.data.name == item.data.name and ingredient.count <= item.count and result.craftable(player):
				is_craftable = true
		if !is_craftable:
			return false
	return true

func play_sound_affect() -> void:
	var tree: SceneTree = Engine.get_main_loop()
	var level: Level = tree.current_scene
	level.play(sound_affect, volume)

func apply(player: Player):
	for ingredient in ingredients:
		for item in player.item_taker.inventory:
			if ingredient.data.name == item.data.name:
				item.count -= ingredient.count
	play_sound_affect()
	result.apply(player)
