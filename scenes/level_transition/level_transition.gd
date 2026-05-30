@tool
extends Area2D

@export var length: int = 3
@export var tile_width: float = 16
@export var direction: directions
@export var camera_zoom: float
@export var next_level: PackedScene

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var camera_boundry: Area2D = $camera_boundry

signal transition(location: Node)

enum directions{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3
}

func setup() -> void:
	camera_boundry.direction = direction
	camera_boundry.length = length
	camera_boundry.tile_width = tile_width
	camera_boundry.camera_zoom = camera_zoom
	collision_shape.shape.size.x = tile_width * length
	
	match direction:
		directions.UP:
			collision_shape.rotation_degrees = 180
		directions.RIGHT:
			collision_shape.rotation_degrees = -90
		directions.LEFT:
			collision_shape.rotation_degrees = 90
		directions.DOWN:
			collision_shape.rotation_degrees = 0

func _on_body_entered(body: Node) -> void:
	if body is Player:
		var next_level_node := next_level.instantiate()
		transition.emit(next_level_node)
		get_tree().change_scene_to_node.call_deferred(next_level_node)

func _ready() -> void:
	setup()
	body_entered.connect(_on_body_entered)
	camera_boundry.setup()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		setup()
