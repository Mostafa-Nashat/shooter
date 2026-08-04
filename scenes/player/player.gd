class_name Player
extends CharacterBody2D

signal died

@export var SPEED: float = 120.0

@export var stun_direction: Vector2 
var kill_count = 0
@export var bullet_max: int = 6
@export var bullet_count: int
@export var frag_max: int = 3
@export var frag_count: int
@export var MAX_HAND_SWING_SPEED: float = 90
@export var blocks: Array[InventoryBlockData]
@export var frag_throw_power: float

@export_category("Dependencies")
@export var tilemap: TileMapLayer
@export var build_ray: FallbackRayCast2D
@export var builder: TileBuilder
@export var health: HealthManager
@export var gun: Gun
@export var sword: Sword
@export var camera: Camera2D
@export var arm: Arm
@export var state: State_machine
@export var item_taker: ItemTaker
@export var animation: AnimationPlayer
@export var hurtbox: Hurtbox
@export var frag_thrower: FragThrower

var weapon_being_used: bool = false

@export_category("HUD")
@export var hud: UI_manager
@export var weapons: BoxContainer
@export var weapon_frames: Frames
@export var bullets: BoxContainer
@export var bullet_texture: Texture2D
@export var hearts: BoxContainer
@export var heart_texture: Texture2D
@export var stamina: ProgressBar
@export var selected_block: TextureRect
@export var inventory: Control
@export var item_grid: GridContainer
@export var recipe_list: BoxContainer
@export var frag_list: BoxContainer
@export var frag_texture: Texture2D

func add_weapon_frame(weapon: Weapon, offset) -> void:
	hud.add_weapon(
		weapons,
		weapon.weapon.sprite,
		weapon_frames,
		offset
	)

func _ready() -> void:
	builder.tilemap = tilemap
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
	weapon.weapon.enabled = true
	weapon.use()
	await weapon.done_using
	weapon.weapon.enabled = false
	await get_tree().create_timer(cooldown).timeout
	weapon_being_used = false

func throw_frag(direction: Vector2) -> void:
	frag_thrower.throw(direction, frag_throw_power, self)
	

func _on_died(_killer: Node2D) -> void:
	died.emit()

func _on_sword_kill() -> void:
	kill_count += 1
	if (kill_count % 2) == 0:
		bullet_count += 1
		bullet_count = clamp(bullet_count, 0 , bullet_max)
	if (kill_count % 5) == 0:
		frag_count += 1
		frag_count = clamp(frag_count, 0, frag_max)
	

func allow_weapon_control() -> void:
	if !sword or !sword.weapon or !sword.animation_player.is_playing():
		arm.look_at_target(get_global_mouse_position(), MAX_HAND_SWING_SPEED)
	if !weapon_being_used:
		if Input.is_action_just_pressed("shoot") and bullet_count > 0:
			bullet_count -= 1
			use_weapon(gun, 0.0)
		if Input.is_action_just_pressed("swing"):
			use_weapon(sword, 0.0)
		if Input.is_action_just_pressed("frag"):
			if frag_count > 0:
				var direction := (get_global_mouse_position() - global_position).normalized()
				throw_frag(direction)
				frag_count -= 1
			
func show_hud_elements() -> void:
	hud.set_items_in_box(int(health.health), heart_texture, hearts)
	hud.set_items_in_box(bullet_count, bullet_texture, bullets)
	hud.set_items_in_box(frag_count, frag_texture, frag_list)

func allow_movement_control() -> void:
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	velocity = direction * SPEED
	if direction.x < 0:
		transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		transform.x = Vector2(1, 0)
	
	if direction:
		animation.play(&"movement/walk_with_free_arm")
	else:
		animation.play(&"movement/RESET")
