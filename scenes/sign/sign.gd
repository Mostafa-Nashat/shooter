@tool
class_name Sign
extends StaticBody2D


@export_multiline() var text: String:
	set(v):
		if label:
			label.text = v
		text = v
@export var shape: Shape2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $popup/Control/PanelContainer/Label
@onready var activation_area_shape: CollisionShape2D = $activation/CollisionShape2D

func _ready() -> void:
	activation_area_shape.shape = shape
	label.text = text


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		activation_area_shape.shape = shape

func _on_activation_body_entered(body: Node2D) -> void:
	if body is Player:
		animation.play("show")

func _on_activation_body_exited(body: Node2D) -> void:
	if body is Player:
		animation.play("hide")
