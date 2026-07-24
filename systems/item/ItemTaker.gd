class_name ItemTaker
extends Area2D

var inventory: Array[InventoryItemData]

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node) -> void:
	if body is Item:
		var item: Item = body
		take_item(item.data, item.count)
		item.queue_free()

func take_item(item: ItemData, count: int) -> void:
	if count == 0:
		return
	for inventory_item in inventory:
		if inventory_item.data.name == item.name:
			inventory_item.count += count
			return
	var inventory_item := InventoryItemData.new()
	inventory_item.count = count
	var item_data := ItemData.new() 
	item_data.name = item.name
	item_data.shape = item.shape
	item_data.texture = item.texture
	inventory_item.data = item_data
	inventory.append(inventory_item)
