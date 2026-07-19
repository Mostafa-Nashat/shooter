class_name WaveSpawner
extends Node

@export var spawn_composer: SpawnComposer
@export var wave_data: Array[WaveData]
@export var wave_delay: float = 1.0
@export var parent: Node2D
@export var player: Player
var wave := 1
var enemy_count := 0
@export var autostart: bool
@export var auto_continue: bool
@export var auto_continue_cooldown: float


signal enemy_died
signal wave_died

func _on_enemy_died():
	enemy_died.emit()
	enemy_count -= 1
	if enemy_count == 0:
		wave_died.emit()
	

func spawn() -> void:
	for data in wave_data:
		for index in wave:
			var interpolcation := 1 - pow(0.99, wave)
			var number := int(data.distribution.sample(interpolcation))
			await spawn_composer.spawn_off_camera(
				parent,
				data.enemy,
				number,
				player
			)
			enemy_count += number
		await  get_tree().create_timer(wave_delay).timeout
	

func _auto_continue():
	wave += 1
	await get_tree().create_timer(auto_continue_cooldown).timeout
	spawn()
	

func _ready() -> void:
	if autostart:
		spawn()
	if auto_continue:
		wave_died.connect(_auto_continue)
	spawn_composer.enemy_died.connect(_on_enemy_died)
