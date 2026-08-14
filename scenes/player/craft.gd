extends State

var player: Player
var recipes: Array[Recipe]
var path := "res://resources/recipes/"
var recipe_item_base := preload("res://scenes/player/inventory/recipe.tscn")


func _setup() -> void:
	player = state.node
	var recipe_files := DirAccess.get_files_at(path)
	for recipe_file in recipe_files:
		var recipe: Recipe = load(path + recipe_file)
		recipes.append(recipe)
	(recipes)
	

func display_items() -> void:
	for item in player.item_taker.inventory:
		var sprite := TextureRect.new()
		sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		sprite.texture = item.data.texture
		player.item_grid.add_child(sprite)
		
		var label := Label.new()
		if item.count == 1:
			label.text = "1 " + item.data.name
		else:
			label.text = str(item.count) + " " + item.data.name
		player.item_grid.add_child(label)

func sort_by_craftability_alpha(a: Recipe, b: Recipe) -> bool:
	var a_proceed := true
	var b_proceed := false
	var a_craftability := a.craftable(player)
	var b_craftability := b.craftable(player)
	if a_craftability and !b_craftability:
		return a_proceed
	elif !a_craftability and b_craftability:
		return b_proceed
		
	if a.title < b.title:
		return a_proceed
	else:
		return b_proceed

func display_recipes() -> void:
	recipes.sort_custom(sort_by_craftability_alpha)
	for recipe in recipes:
		var recipe_item: RecipeListItem = recipe_item_base.instantiate()
		recipe_item.data = recipe
		recipe_item.player = player
		recipe_item.crafted.connect(update_items)
		player.recipe_list.add_child(recipe_item)

func update_items() -> void:
	for item in player.item_grid.get_children():
		item.queue_free()
	remove_zero_items()
	display_items()

func _start():
	player.bullets.visible = false
	player.hearts.visible = false
	player.stamina.visible = false
	player.inventory.visible = true
	
	remove_zero_items()
	display_items()
	display_recipes()


func remove_zero_items() -> void:
	player.item_taker.inventory = player.item_taker.inventory.filter(func(item: InventoryItemData): return item.count > 0)
	
func _update():
	if Input.is_action_just_pressed("inventory"):
		state.switch_state("ground")

func _end():
	player.bullets.visible = true
	player.hearts.visible = true
	player.stamina.visible = true
	player.inventory.visible = false

	for child in player.item_grid.get_children():
		child.queue_free()
	for child in player.recipe_list.get_children():
		child.queue_free()
	
