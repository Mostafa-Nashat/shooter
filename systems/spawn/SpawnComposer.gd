class_name SpawnComposer
extends Node

var spawners: Array[Enemy_Spawner]
@export var recursive_delay: float = 1.0

signal enemy_died

func _ready() -> void:
	for child in get_children():
		if child is Enemy_Spawner:
			spawners.append(child)

func _valid(spawner: Enemy_Spawner):
	return !spawner.on_camera and spawner.overlapping_bodies == 0

func _sort_by_closest(target: Node2D, a: Node2D, b: Node2D):
	var target_distance_a = abs(a.global_position - target.global_position)
	var target_distance_b = abs(b.global_position - target.global_position)
	return target_distance_a < target_distance_b


func spawn_off_camera(
	parent: Node2D, 
	enemy: PackedScene, 
	number: int,
	closest_to: Node2D,
	setup: Callable
	):
	var valid_spawners := spawners.filter(_valid)
	valid_spawners.sort_custom(_sort_by_closest.bind(closest_to))
	if number > len(valid_spawners):
		for spawner in valid_spawners:
			spawner.spawn(parent, enemy, setup)
		await get_tree().create_timer(recursive_delay).timeout
		var enemies_left := number - len(valid_spawners)
		await spawn_off_camera(parent, enemy, enemies_left, closest_to, setup)
	else:
		for index in number:
			var spawner: Enemy_Spawner = valid_spawners[index]
			await spawner.spawn(parent, enemy, setup)
