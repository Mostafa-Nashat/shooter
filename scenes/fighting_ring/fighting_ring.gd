extends Node2D

@export var spawners: Node2D
@export var enemies: Node2D
@export var player: Player
@onready var camera: Camera2D = player.camera
@export_range(3.0, 1.0, 0.1, "or_greater", "prefer_slider") var spawn_delay: float
@export_range(3.0, 1.0, 0.1, "or_greater", "prefer_slider") var wave_delay: float

var wave := 1
var enemy_count := 0

var enemy: PackedScene = preload("res://scenes/enemy/enemy.tscn")

func spawner_logic(spawner: Area2D) -> bool:
	await wait_physics_frame(1)
	for area in spawner.get_overlapping_areas():
		if area.get_collision_layer_value(4):
			return false
	for body in spawner.get_overlapping_bodies():
		if body is PhysicsBody2D:
			return false
	return true
	

func sort_by_distance(a: Area2D, b: Area2D):
	var distance_a: float = abs(player.global_position - a.global_position).length()
	var distance_b: float = abs(player.global_position - b.global_position).length()
	if distance_a < distance_b:
		return true
	return false

func spawn_enemy(spawner_position: Vector2) -> void:
	var enemy_node: Enemy = enemy.instantiate()
	enemy_node.position = spawner_position
	enemy_node.died.connect(_on_enemy_died)
	enemies.add_child(enemy_node)
	enemy_count += 1

func spawn_enemy_attempt(number: int) -> void:
	var spawners_parent = spawners.get_children()
	spawners_parent.sort_custom(sort_by_distance)
	var valid_spawners: Array[Area2D]
	for node in spawners_parent:
		var spawner: Area2D = node
		var valid: bool = await spawner_logic(spawner)
		if valid:
			valid_spawners.append(spawner)
	if len(valid_spawners) == 0:
		return
	print("number: ", number)
	print("valid_spawners:", len(valid_spawners))
	if number > len(valid_spawners):
		for spawner in valid_spawners:
			spawn_enemy(spawner.position)
			await get_tree().create_timer(spawn_delay).timeout
			spawn_enemy_attempt(number - len(valid_spawners)) 
		return
	for index in range(number):
		spawn_enemy(valid_spawners[index].position)

func wait_physics_frame(count: int) -> void:
	for index in range(count):
		await get_tree().create_timer(get_physics_process_delta_time()).timeout

func _ready() -> void:
	await wait_physics_frame(2)
	spawn_enemy_attempt(wave)

func _on_enemy_died():
	enemy_count -= 1
	if enemy_count > 0:
		return
	wave += 1
	spawn_enemy_attempt(wave)
	 
