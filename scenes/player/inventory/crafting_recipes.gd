class_name RecipeList
extends VBoxContainer

func _ready() -> void:
	DirAccess.get_files_at("res://")
