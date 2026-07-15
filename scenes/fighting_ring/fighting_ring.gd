extends Node2D

@export var ground: TileMapLayer
@export var player: Player
@export var spawn_radius_range: Vector2
@export var spawn_timer: float = 5.0

var enemy: PackedScene = preload("res://scenes/enemy/enemy.tscn")

func start_timer(time: float, callback: Callable):
	get_tree().create_timer(time, false).timeout.connect(callback)

func _ready() -> void: 
	start_timer(spawn_timer, spawn_enemy)

func calculate_enenmy_position(enemy_node: Enemy):
	var x_ratio := randf_range(0, 1)
	var y_ratio := 1 - x_ratio
	var spawn_radius := randf_range(spawn_radius_range.x, spawn_radius_range.y)
	enemy_node.position.x = player.position.x + (spawn_radius * x_ratio)
	enemy_node.position.y = player.position.y + (spawn_radius * y_ratio)

func spawn_enemy(recursion_index: int = 0) -> void:
	if recursion_index > 5:
		print("recursion")
		start_timer(spawn_timer, spawn_enemy)
		return
		
	var enemy_node: Enemy = enemy.instantiate()
	calculate_enenmy_position(enemy_node)
	var enemy_tile_position = Vector2i(
		enemy_node.position.x / ground.tile_set.tile_size.x,
		enemy_node.position.y / ground.tile_set.tile_size.y
	)
	var used_cells := ground.get_surrounding_cells(enemy_tile_position)
	for cell in used_cells:
		var cell_data := ground.get_cell_tile_data(cell)
		if !cell_data:
			continue
		if cell_data.get_collision_polygons_count(0) != 0:
			continue
		add_child(enemy_node)
		start_timer(spawn_timer, spawn_enemy)
		return 
	spawn_enemy(recursion_index + 1) 
