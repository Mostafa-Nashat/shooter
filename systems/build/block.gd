class_name Block
extends StaticBody2D

@export var data: BlockData

@export_category("dependencies")
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D
@export var health: HealthManager
@export var hurtbox_collision_shape: CollisionShape2D

var skipped_frame := false 
var done := false 

func _ready() -> void:
	if health:
		hurtbox_collision_shape.shape = data.shape
		health.health = data.health
		health.died.connect(queue_free)
	place_if_valid()

func place_if_valid() -> void:
	var space_state := get_world_2d().direct_space_state
	var physics_shape_query_params := PhysicsShapeQueryParameters2D.new()
	physics_shape_query_params.shape = data.shape
	physics_shape_query_params.transform.origin = global_position
	for body in space_state.intersect_shape(physics_shape_query_params):
		if body["collider"] is StaticBody2D:
			continue
		queue_free()
		return
	sprite.texture = data.texture
	collision_shape.shape = data.shape
