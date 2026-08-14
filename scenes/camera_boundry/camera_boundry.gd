@tool
extends Area2D

@export var length: int = 3
@export var tile_width: float = 16
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var direction: directions
@export var camera_zoom: float

enum directions{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3
}

func get_viewport_width() -> float:
	var length: float = ProjectSettings.get_setting("display/window/size/viewport_width")
	return length

func get_viewport_height() -> float:
	var length: float = ProjectSettings.get_setting("display/window/size/viewport_height")
	return length

func setup() -> void:
	collision_shape.shape.size.x = tile_width * length
	
	match direction:
		directions.UP:
			rotation_degrees = 180
		directions.RIGHT:
			rotation_degrees = -90
		directions.LEFT:
			rotation_degrees = 90
		directions.DOWN:
			rotation_degrees = 0
	
	if direction == directions.UP || direction == directions.DOWN:
		collision_shape.shape.size.y = get_viewport_height() * (1 + 1 - camera_zoom) / 2
		collision_shape.position.y = get_viewport_height() * (1 + 1 - camera_zoom) / 4 
	else:
		collision_shape.shape.size.y = get_viewport_width() * (1 + 1 - camera_zoom) / 2
		collision_shape.position.y = get_viewport_width()  * (1 + 1 - camera_zoom) / 4

func detect_camera() -> void:
	for body in get_overlapping_bodies():
		if body is Player:
			match direction:
				directions.RIGHT:
					body.camera.global_position.x = global_position.x + get_viewport_width() * (1 + 1 - camera_zoom) / 2
				directions.LEFT:
					body.camera.global_position.x = global_position.x - get_viewport_width() * (1 + 1 - camera_zoom) / 2
				directions.UP:
					body.camera.global_position.y = global_position.y - get_viewport_height() * (1 + 1 - camera_zoom) / 2
				directions.DOWN:
					body.camera.global_position.y = global_position.y + get_viewport_height() * (1 + 1 - camera_zoom) / 2
				_:
					body.camera.global_position = Vector2.ZERO


func _on_body_exited(body: Node) -> void:
	if body is Player:
		body.camera.top_level = false

func _ready() -> void:
	setup()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		setup()
	detect_camera()
