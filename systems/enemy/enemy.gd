class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 50 
@export var drops: Array[ItemDrop] = []
@export var drop_speed : float = 50.0
@export var enabled: bool = true

@export_category("Dependencies")
@export var state_machine: State_machine 
@export var arm: Arm
@export var navigator: NavigationAgent2D
@export var health: HealthManager
@export var item_droper: ItemDroper
@export var collision_offset := 60
@export var animation: AnimationPlayer
@export var hurtbox: Hurtbox
@export var audio_player: AudioStreamPlayer2D
@export var hit_sound_affect: AudioStreamPlayer2D
@onready var ground_audio_player := SurfaceBasedAudioPlayer.create("res://assets/audio/footsteps/", audio_player)

func enable() -> void:
	enabled = true

var next_direction: Vector2
var next_path_position: Vector2
var tilemap: TileMapLayer
var stun_direction: Vector2

signal died

func play_random_hit_audio(_hp, _damager) -> void:
	hit_sound_affect.play()

func _ready() -> void:
	if !get_tree().current_scene:
		return
	var level: Level = get_tree().current_scene
	tilemap = level.ground_layer
	health.died.connect(_on_died)
	health.damaged.connect(play_random_hit_audio)
	health.damaged.connect(_on_damaged)
	set_next_direction()

func drop_item(drop: ItemDrop, damager: Node2D) -> void:
	item_droper.knock_from(drop.item.data, drop.item.count, damager, drop_speed)

func _on_damaged(_hp, damager: Node2D) -> void:
	stun_direction = -(damager.global_position - global_position).normalized()
	_stun()

func _stun() -> void:
	pass

var enemy_collision_fallsafe_int: int = 0

func enemy_collision_fallsafe() -> void:
	if enemy_collision_fallsafe_int == 50:
		position.x += 50
	for body in hurtbox.get_overlapping_bodies():
		if body is Enemy:
			enemy_collision_fallsafe_int += 1
			return
	enemy_collision_fallsafe_int = 0

func _physics_process(_delta: float) -> void:
	enemy_collision_fallsafe()
	if !enabled:
		velocity = Vector2.ZERO
		return
	state_machine.update()
	move_and_slide()

func drop_items(killer: Node2D) -> void:
	for drop in drops:
		if drop.weight > 1:
			while drop.weight > 1:
				drop_item(drop, killer)
		if drop.weight > 0:
			var random_number := randf_range(0, 1.0)
			if drop.weight > random_number:
				drop_item(drop, killer)

func _on_died(killer: Node2D) -> void:
	drop_items(killer)
	queue_free()
	died.emit()

func set_next_direction() -> void:
	next_direction = (navigator.get_next_path_position() - global_position).normalized()
	next_path_position = navigator.get_next_path_position()
	if get_tree():
		get_tree().create_timer(1.0/10).timeout.connect(set_next_direction, CONNECT_ONE_SHOT)

func get_next_direction() -> Vector2:
	return next_direction

func get_next_path_position() -> Vector2:
	return next_path_position

func go_to(target: Vector2, speed: float) -> void:
	ground_audio_player.play_surface_audio(tilemap, global_position, "audio")
	navigator.target_position = target
	var velocity_direction := (get_next_path_position() - global_position).normalized()
	velocity = velocity_direction * speed
