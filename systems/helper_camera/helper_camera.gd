class_name HelperCamera2D
extends Camera2D

# this camera just helps me know what the player sees in the editor
# since I have my game strechec so the normal camera is 4 times too big

@export var intended_zoom: Vector2 = Vector2(1, 1)
@export var hitbox: Area2D 

func _ready() -> void:
	zoom = intended_zoom
	var rect := RectangleShape2D.new()
	var stretch_scale: int = ProjectSettings.get_setting("display/window/stretch/scale")
	rect.size = DisplayServer.screen_get_size()  / stretch_scale
	var shape = CollisionShape2D.new()
	shape.shape = rect
	hitbox.add_child(shape)
