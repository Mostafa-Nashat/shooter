class_name Weapon
extends Node2D

@export var weapon: Weapon_data

func start() -> void:
	if weapon.enabled:
		visible = true
		_start()
	else:
		visible = false

func physics_update(delta: float) -> void:
	if weapon.enabled:
		visible = true
		_physics_update(delta)
	else:
		visible = false

func _physics_update(_delta: float) -> void:
	pass

func _start() -> void:
	pass
