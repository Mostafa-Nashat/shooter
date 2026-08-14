@tool
extends Area2D

@export var activation_shape: Shape2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var player: Player

func _on_body_entered(body: Node) -> void:
	if body is Player:
		player = body
		var connections: Array = body.died.get_connections()
		for connection in connections:
			var callable: Callable = connection["callable"]
			body.died.disconnect(callable)
		if !body.died.is_connected(_spawn_player):
			audio.play()
			body.died.connect(_spawn_player)

func _spawn_player() -> void:
	player.health.set_health_to_max()
	player.global_position = global_position
	player.item_taker.inventory = []
	

func _ready() -> void:
	collision_shape.shape = activation_shape
	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape.shape = activation_shape
