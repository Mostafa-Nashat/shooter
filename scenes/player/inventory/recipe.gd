class_name RecipeListItem
extends HBoxContainer

@export var data: Recipe

@export var player: Player
@export var preview_texture: TextureRect
@export var title: Label
@export var description: Label
@export var needs: Label
@export var button: Button

signal crafted

func _ready() -> void:
	preview_texture.texture = data.preview
	title.text = data.title
	description.text = data.description
	needs.text = "ingredients:"
	for ingredient in data.ingredients:
		needs.text += " " + str(ingredient.count) + " " + ingredient.data.name
	if !data.craftable(player):
		button.disabled = true
	button.button_up.connect(apply)

func apply() -> void:
	data.apply(player)
	crafted.emit()


func _process(_delta: float) -> void:
	if !data.craftable(player):
		button.disabled = true
	else:
		button.disabled = false
