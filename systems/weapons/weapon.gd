class_name Weapon
extends Node2D

@export var weapon: Weapon_data

func start() -> void:
	if weapon.enabled:
		visible = true
		_start()
	else:
		visible = false


func update() -> void:
	if weapon.enabled:
		visible = true
		_update() 
	else:
		visible = false

func use() -> void:
	if weapon.enabled:
		visible = true
		_use()
	else: 
		visible = false
	

func _use() -> void:
	pass

func _update() -> void:
	pass

func _start() -> void:
	pass
