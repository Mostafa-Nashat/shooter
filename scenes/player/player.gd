class_name Player
extends CharacterBody2D

@export var SPEED: float = 120.0
@export var MAX_HAND_SWING_SPEED: float = 20

@export var sprite: Sprite2D
@export var ui_manager: UI_manager

@export var gun: Gun

@export var health: HealthManager

@export var arm: Arm
@export var arm_visibility_timer: Timer

func _ready() -> void:
	if gun.weapon:
		ui_manager.set_gun_sprite(gun.weapon.sprite)
		gun.start()
	health.set_health(5)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	velocity = direction * SPEED
	
	arm.look_at_target(get_global_mouse_position(), MAX_HAND_SWING_SPEED)
	if arm_visibility_timer.is_stopped():
		arm.visible = false
	else:
		arm.visible = true
	
	gun.update()
	
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
	
	if Input.is_action_just_pressed("shoot"):
		arm_visibility_timer.start()
		gun.use()
	
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet: Bullet = area
		health.damage(bullet.bullet.damage)

func _on_died() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen/home_screen.tscn")
