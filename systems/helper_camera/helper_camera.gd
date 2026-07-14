class_name HelperCamera2D
extends Camera2D

# this camera just helps me know what the player sees in the editor
# since I have my game strechec so the normal camera is 4 times too big

@export var intended_zoom: Vector2 = Vector2(1, 1)

func _ready() -> void:
	zoom = intended_zoom
