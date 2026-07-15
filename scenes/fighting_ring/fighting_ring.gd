extends Node2D

@export var spawners: Node2D
@export var spawn_time: float = 5.0
@export var player: Player
@onready var camera: Camera2D = player.camera

var enemy: PackedScene = preload("res://scenes/enemy/enemy.tscn")

func start_timer(callback: Callable) -> void:
	get_tree().create_timer(spawn_time).timeout.connect(callback)

func spawner_logic(spawner: Area2D) -> bool:
	for area in spawner.get_overlapping_areas():
		if area.get_collision_layer_value(4):
			return false
	for body in spawner.get_overlapping_bodies():
		return false
	spawn_enemy(spawner.position)
	return true
	

func sort_by_distance(a: Area2D, b: Area2D):
	var distance_a: float = abs(player.global_position - a.global_position).length()
	var distance_b: float = abs(player.global_position - b.global_position).length()
	if distance_a < distance_b:
		return true
	return false

func spawn_enemy(position: Vector2) -> void:
	var enemy_node: Enemy = enemy.instantiate()
	enemy_node.position = position
	add_child(enemy_node)

func spawn_enemy_attempt() -> void:
	var children = spawners.get_children()
	children.sort_custom(sort_by_distance)
	for node in spawners.get_children():
		var spawner: Area2D = node
		var valid: bool = spawner_logic(spawner)
		if valid:
			break
	start_timer(spawn_enemy_attempt)
	
func _ready() -> void:
	start_timer(spawn_enemy_attempt)
