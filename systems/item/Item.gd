class_name Item
extends RigidBody2D

@export var data: ItemData
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D

func _ready() -> void:
	sprite.texture = data.texture
	collision_shape.shape = data.shape
