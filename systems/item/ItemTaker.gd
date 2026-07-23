class_name ItemTaker
extends Area2D

var inventory: Array[ItemData]

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node) -> void:
	if body is Item:
		var item: Item = body
		take_item(item.data)
		item.queue_free()

func take_item(item: ItemData) -> void:
	if item.count == 0:
		return
	for inventory_item in inventory:
		if inventory_item.name == item.name:
			inventory_item.count += item.count
			return
	inventory.append(item)
