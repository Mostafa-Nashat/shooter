class_name HelperCamera2D
extends Camera2D

@export var hitbox: Area2D 

func _ready() -> void:
	var rect := RectangleShape2D.new()
	rect.size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	rect.size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	print(rect.size)
	var shape = CollisionShape2D.new()
	shape.shape = rect
	hitbox.add_child(shape)
