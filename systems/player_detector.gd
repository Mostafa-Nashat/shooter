class_name PlayerDetector
extends Area2D

signal entered
signal exited

func _on_body_entered(body: Node) -> void:
	if body is Player:
		entered.emit()

func _on_body_exited(body: Node) -> void:
	if body is Player:
		exited.emit()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
