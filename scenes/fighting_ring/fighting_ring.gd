extends Node2D

@export var spawners: Node2D
@export var enemies: Node2D
@export var player: Player
@onready var camera: Camera2D = player.camera
@export_range(3.0, 5.0, 0.1, "or_greater", "prefer_slider") var spawn_delay: float = 3.0
@export_range(1.0, 100.0, 0.1, "or_greater", "prefer_slider") var wave_delay: float = 3.0
@export var enemy_number_prefix: String = "Enemies left: "
@export var wave_prefix: String = "Wave: "
var enemy_number_label: Label = preload("res://scenes/fighting_ring/enemy_count_label.tscn").instantiate()
var wave_label: Label = preload("res://scenes/fighting_ring/wave_label.tscn").instantiate()


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
	await spawn_enemy_attempt(wave)
	enemy_number_label.text = enemy_number_prefix + str(enemy_count)
	wave_label.text = wave_prefix + str(wave)
	player.hud.add_child(enemy_number_label)
	player.hud.add_child(wave_label)
	

func _on_enemy_died():
	enemy_count -= 1
	enemy_number_label.text = enemy_number_prefix + str(enemy_count)
	if enemy_count > 0:
		return
	enemy_number_label.visible = false
	wave += 1
	wave_label.text = wave_prefix + str(wave)
	await get_tree().create_timer(wave_delay).timeout
	await spawn_enemy_attempt(wave)
	enemy_number_label.text = enemy_number_prefix + str(enemy_count)
	enemy_number_label.visible = true

var death_screen := preload("res://scenes/survival_death_screen/survival_death_screen.tscn")

func _on_player_died() -> void:
	var death_screen_node :=  death_screen.instantiate()
	death_screen_node.died_on_wave = wave
	get_tree().change_scene_to_node(death_screen_node)
