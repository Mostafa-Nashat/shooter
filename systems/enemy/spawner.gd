@tool
class_name Enemy_Spawner
extends Area2D

signal enemy_died

@export var radius: int = 32
var on_camera: bool = false

func add_collision_shape() -> void:
	var collision_shape := CollisionShape2D.new()
	var shape := CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	add_child(collision_shape)

func _ready() -> void:
	add_collision_shape()
	set_collision_mask_value(4, true)
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	area_entered.connect(func(): on_camera = true)
	area_exited.connect(func(): on_camera = false)

func spawn(parent: Node2D, child: Enemy):
	child.died.connect(enemy_died.emit)
	child.global_position = global_position
	parent.add_child(child)
