extends State

var player: Player
var tile_blocks: Array[TileBlock]

var base_block := preload("res://systems/build/base_block.tscn")
var selected_block: int = 0

class TileBlock:
	var block: InventoryBlockData
	var id: int

func remove_zero_blocks():
	var filtered_blocks: Array = player.blocks.filter(func(block: InventoryBlockData): return !block.count == 0)
	player.blocks.assign(filtered_blocks)
	tile_blocks = tile_blocks.filter(func(tile_block: TileBlock): return !tile_block.block.count == 0)

func filter_added_blocks(block: InventoryBlockData) -> bool:
	for tile_block in tile_blocks:
		if block.data.name == tile_block.block.data.name:
			return false
	return true

func add_block(block_data: InventoryBlockData) -> void:
	var block := base_block.instantiate()
	block.data = block_data.data
	var unique_id = player.builder.add_block(block)
	var tile_block := TileBlock.new()
	tile_block.block = block_data
	tile_block.id = unique_id
	tile_blocks.append(tile_block)

func update_blocks() -> void:
	remove_zero_blocks()
	var new_blocks := player.blocks.filter(filter_added_blocks)
	for block_data: InventoryBlockData in new_blocks:
		add_block(block_data)

func place_block():
	var global_build_target := player.build_ray.get_collision_point_or_fallback()
	var local_build_target := player.tilemap.to_local(global_build_target)
	var grid_build_target := player.tilemap.local_to_map(local_build_target)
	var successful := player.builder.place_block(tile_blocks[selected_block].id, grid_build_target)
	if successful:
		tile_blocks[selected_block].block.count -= 1
	
func _start():
	player = state.node
	player.bullets.visible = false
	player.weapons.visible = false
	player.selected_block.visible = true
	update_blocks()

func _update():
	if Input.is_action_just_pressed("combat"):
		state.switch_state("ground")
		return
	if Input.is_action_just_pressed("inventory"):
		state.switch_state("craft")
		return
	player.allow_movement_control()
	player.arm.look_at_target(player.get_global_mouse_position(), player.MAX_HAND_SWING_SPEED)
	
	update_blocks()
	if len(tile_blocks) == 0:
		player.selected_block.texture = null
		return
	if Input.is_action_just_pressed("select_up"):
		selected_block += 1
	if Input.is_action_just_pressed("select_down"):
		selected_block -= 1
	selected_block = clampi(selected_block, 0, len(tile_blocks) - 1)
	if Input.is_action_just_pressed("place"):
		place_block()
	
	player.selected_block.texture = tile_blocks[selected_block].block.data.texture

	
func _end():
	player.bullets.visible = true
	player.weapons.visible = true
	player.selected_block.visible = false
