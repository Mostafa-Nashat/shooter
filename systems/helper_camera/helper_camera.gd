class_name HelperCamera2D
extends Camera2D

@export var hitbox: Area2D 
@export var target: Node2D

func _ready() -> void:
	var rect := RectangleShape2D.new()
	rect.size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	rect.size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	var shape = CollisionShape2D.new()
	shape.shape = rect
	top_level = true
	hitbox.add_child(shape)

func _process(_delta: float) -> void:
	global_position = target.global_position
