@tool
class_name Enemy_Spawner
extends Area2D

signal enemy_died

@export var radius: int = 32
var on_camera: bool = false
var overlapping_bodies := 0

func _body_entered(body: PhysicsBody2D):
	if body is CharacterBody2D:
		overlapping_bodies += 1

func _body_exited(body: PhysicsBody2D):
	if body is CharacterBody2D:
		overlapping_bodies -= 1

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
	area_entered.connect(func(_area): on_camera = true)
	area_exited.connect(func(_area): on_camera = false)
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func spawn(parent: Node2D, child: PackedScene):
	var enemy: Enemy = child.instantiate()
	enemy.died.connect(enemy_died.emit)
	enemy.global_position = global_position
	parent.add_child.call_deferred(enemy)
