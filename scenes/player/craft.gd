extends State

var player: Player

func _start():
	player = state.node
	
	player.bullets.visible = false
	player.hearts.visible = false
	player.weapons.visible = false
	player.stamina.visible = false
	player.inventory.visible = true
	
	remove_zero_items()
	for item in player.item_taker.inventory:
		var sprite := TextureRect.new()
		sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		sprite.texture = item.data.texture
		player.inventory_grid.add_child(sprite)
		
		var label := Label.new()
		if item.count == 1:
			label.text = "1 " + item.data.name
		else:
			label.text = str(item.count) + " " + item.data.name
		player.item_grid.add_child(label)

func remove_zero_items() -> void:
	player.item_taker.inventory = player.item_taker.inventory.filter(func(item: InventoryItemData): return item.count > 0)
	
func _update():
	if Input.is_action_just_pressed("inventory"):
		state.switch_state("ground")

func _end():
	player.bullets.visible = true
	player.hearts.visible = true
	player.weapons.visible = true
	player.stamina.visible = true
	player.inventory.visible = false

	for child in player.item_grid.get_children():
		child.queue_free()
	
