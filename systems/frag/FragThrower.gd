class_name FragThrower
extends Node2D

@export var frag_scene: PackedScene
@export var player_freindly: bool = false

func throw(direction: Vector2, power: float, ...exeptions: Array) -> void:
	if !frag_scene.can_instantiate():
		printerr("no frag to throw")
		return
	var frag: SelectiveFrag = frag_scene.instantiate()
	frag.direction = direction
	frag.throw_power = power
	frag.global_position = global_position
	frag.player_freindly = player_freindly
	for exeption in exeptions:
		frag.add_collision_exception_with(exeption)
	get_tree().root.get_child(0).add_child(frag)
