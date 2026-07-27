class_name ItemDroper
extends Node2D

var base_item := preload("res://systems/item/base_item.tscn")

func drop(item: ItemData, count: int, direction: Vector2, speed: float) -> void:
	var item_node: Item = base_item.instantiate()
	item_node.data = item
	item_node.count = count
	item_node.global_position = global_position
	item_node.linear_velocity = direction.normalized() * speed
	var root := get_tree().root
	root.add_child(item_node)

func knock_from(item: ItemData, count: int , from: Node2D, speed: float) -> void:
	var item_node: Item = base_item.instantiate()
	item_node.data = item
	item_node.count = count
	item_node.global_position = global_position
	var direction := -(from.global_position - global_position).normalized()
	item_node.linear_velocity = direction * speed
	var root := get_tree().root
	root.add_child(item_node)
