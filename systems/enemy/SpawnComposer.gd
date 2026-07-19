class_name SpawnComposer
extends Node

var spawners: Array[Enemy_Spawner]
@export var recursive_delay: float = 1.0

signal enemy_died

func _ready() -> void:
	for child in get_children():
		if child is Enemy_Spawner:
			spawners.append(child)
			child.enemy_died.connect(enemy_died.emit)

func _spawner_off_camera(spawner: Enemy_Spawner):
	return !spawner.on_camera

func _sort_by_closest(target: Node2D, a: Node2D, b: Node2D):
	var target_distance_a = abs(a.global_position - target.global_position)
	var target_distance_b = abs(b.global_position - target.global_position)
	return target_distance_a < target_distance_b

func spawn_off_camera(
	parent: Node2D, 
	enemy: PackedScene, 
	number: int,
	closest_to: Node2D
	):
	print(number)
	var valid_spawners := spawners.filter(_spawner_off_camera)
	valid_spawners.sort_custom(_sort_by_closest.bind(closest_to))
	if number > len(valid_spawners):
		print("recurse")
		for spawner in valid_spawners:
			spawner.spawn(parent, enemy)
			print(spawner)
		await get_tree().create_timer(recursive_delay).timeout
		var enemies_left := number - len(valid_spawners)
		spawn_off_camera(parent, enemy, enemies_left, closest_to)
	else:
		print("normal")
		for index in number:
			var spawner: Enemy_Spawner = valid_spawners[index]
			print(spawner)
			spawner.spawn(parent, enemy)
