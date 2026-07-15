class_name Player
extends CharacterBody2D

@export var SPEED: float = 120.0
@export var MAX_HAND_SWING_SPEED: float = 20

@export var sprite: Sprite2D
@export var ui_manager: UI_manager

@export var gun: Gun
@export var sword: Sword
@export var camera: Camera2D

@export var arm: Arm
@export var arm_visibility_timer: Timer

var weapon_being_used: bool = false

func _ready() -> void:
	arm.visible = false
	if gun.weapon:
		ui_manager.add_weapon_display(gun.weapon.sprite)
	if sword.weapon:
		ui_manager.add_weapon_display(sword.weapon.sprite)
	ready.emit()

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	velocity = direction * SPEED
	
	arm.look_at_target(get_global_mouse_position(), MAX_HAND_SWING_SPEED)
	
	if direction.x < 0:
		transform.x = Vector2(-1, 0)
		ui_manager.transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		transform.x = Vector2(1, 0)
		ui_manager.transform.x = Vector2(1, 0)
	
	if !weapon_being_used:
		if Input.is_action_just_pressed("shoot"):
			use_weapon(gun, 0.0)
		if Input.is_action_just_pressed("swing"):
			use_weapon(sword, 0.2)
			
	
	move_and_slide()

func use_weapon(weapon: Weapon, cooldown: float):
	weapon_being_used = true
	arm.visible = true
	weapon.weapon.enabled = true
	weapon.use()
	await weapon.done_using
	weapon.weapon.enabled = false
	arm.visible = false
	await get_tree().create_timer(cooldown).timeout
	weapon_being_used = false

func _on_died() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen/home_screen.tscn")
