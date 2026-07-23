class_name TileBuilder
extends Node

@export var tilemap: TileMapLayer
var source_id: int

func add_scene_source() -> void:
	var source := TileSetScenesCollectionSource.new()
	source_id = tilemap.tile_set.add_source(source)


func _ready() -> void:
	add_scene_source.call_deferred()

func add_block(block: Block) -> int:
	var source: TileSetScenesCollectionSource = tilemap.tile_set.get_source(source_id)
	var scene := PackedScene.new()
	scene.pack(block)
	var unique_id := source.create_scene_tile(scene)
	return unique_id

func place_block(unique_id: int, coords: Vector2i) -> bool:
	for cell in tilemap.get_used_cells_by_id(source_id, Vector2i.ZERO, unique_id):
		if cell == coords:
			return false
	tilemap.set_cell(coords, source_id, Vector2i.ZERO, unique_id)
	return true
