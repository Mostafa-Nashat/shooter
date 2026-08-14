@tool
class_name Gate
extends StaticBody2D

@export var tile_size: float = 16
@export var length: int = 1
@export var orientation: orientations

@export var collision_shape: CollisionShape2D

enum orientations{
	VERTICAL,
	HORIZONTAL
}

func assign_shape() -> void:
	var rectangle = RectangleShape2D.new()
	rectangle.size.x = tile_size * length
	rectangle.size.y = 2
	collision_shape.shape = rectangle

func rotate_to_orientation() -> void:
	match orientation:
		orientations.VERTICAL:
			global_rotation_degrees = 90
		orientations.HORIZONTAL:
			global_rotation_degrees = 0

func open() -> void:
	collision_shape.set_deferred("disabled", true)

func close() -> void:
	collision_shape.set_deferred("disabled", false)


func _ready() -> void:
	assign_shape()
	rotate_to_orientation()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		assign_shape()
		rotate_to_orientation()
