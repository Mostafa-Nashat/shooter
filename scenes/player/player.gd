class_name Player
extends CharacterBody2D

signal died

@export var SPEED: float = 120.0
@export var MAX_HAND_SWING_SPEED: float = 90

@export var sprite: Sprite2D
@export var health: HealthManager

@export var gun: Gun
@export var sword: Sword
@export var camera: Camera2D
@export var deflipper: Node2D
@export var bullet_count: int
var kill_count = 0
@export var bullet_max: int = 6
@export var arm: Arm
@export var state: State_machine

var weapon_being_used: bool = false

@export_group("HUD")
@export var hud: UI_manager
@export var weapons: BoxContainer
@export var weapon_frames: Frames
@export var bullets: BoxContainer
@export var bullet_texture: Texture2D
@export var hearts: BoxContainer
@export var heart_texture: Texture2D
@export var stamina: ProgressBar

func add_weapon_frame(weapon: Weapon, offset) -> void:
	hud.add_weapon(
		weapons,
		weapon.weapon.sprite,
		weapon_frames,
		offset
	)

func _ready() -> void:
	arm.visible = false
	if sword.weapon:
		var offset = Vector2(4.0, 0)
		add_weapon_frame(sword, offset)
	if gun.weapon:
		var offset = Vector2.ZERO
		add_weapon_frame(gun, offset)
	ready.emit()

func _physics_process(_delta: float) -> void:
	state.update()
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
	died.emit()

func _on_sword_kill() -> void:
	kill_count += 1
	if (kill_count % 2) == 0:
		kill_count = 0
		bullet_count += 1
	bullet_count = clamp(bullet_count, 0 , bullet_max)

func allow_weapon_control() -> void:
	if !weapon_being_used:
		if Input.is_action_just_pressed("shoot") and bullet_count > 0:
			bullet_count -= 1
			use_weapon(gun, 0.0)
		if Input.is_action_just_pressed("swing"):
			use_weapon(sword, 0.0)

func show_hud_elements() -> void:
	hud.set_items_in_box(int(health.health), heart_texture, hearts)
	hud.set_items_in_box(bullet_count, bullet_texture, bullets)
