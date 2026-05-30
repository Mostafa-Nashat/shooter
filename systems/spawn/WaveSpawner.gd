class_name WaveSpawner
extends Node

@export var spawn_composer: SpawnComposer
@export var wave_data: Array[WaveData]
@export var wave_delay: float = 1.0
@export var parent: Node2D
@export var player: Player
var wave := 1
var enemy_count: int = 0
@export var autostart: bool
@export var auto_continue: bool
@export var auto_continue_cooldown: float
@export_range(0, 1.0, 0.01) var interpolation_speed: float


signal enemy_died
signal wave_died
signal finite_wave_finished

func _on_enemy_died():
	print("id: ", self)
	print("enemy_count: ", get("enemy_count"))
	enemy_count += -1
	if enemy_count <= 0:
		wave_died.emit()
	

func spawn() -> void:
	for data in wave_data: 
		var interpolcation := 1 - pow(interpolation_speed, wave)
		var number := roundi(data.distribution.sample(interpolcation))
		if number <= 0:
			continue
		await spawn_composer.spawn_off_camera(
			parent,
			data.enemy,
			number,
			player,
			data.setup.callback
		)
		print("enemy_count_before: " , enemy_count)
		enemy_count += number
		print("number: " , number)
		print("enemy_count_after: " , enemy_count)
		await  get_tree().create_timer(wave_delay).timeout
	

func _auto_continue():
	wave += 1
	await get_tree().create_timer(auto_continue_cooldown).timeout
	await spawn()


func spawn_wave(count: int, cooldown: float) -> void:
	for index in count:
		await get_tree().create_timer(cooldown).timeout
		await spawn()
		print("spawned")
		get_tree().create_timer(0.1).timeout.connect(func(): if enemy_count == 0: wave_died.emit())
		await wave_died
		print('wave died') 
	finite_wave_finished.emit()

func _ready() -> void:
	print("ready")
	wave_died.connect(func(): print("hello"))
	enemy_died.connect(_on_enemy_died)
	for data in wave_data:
		data.setup.wave_spawner = self
	if autostart:
		spawn()
	if auto_continue:
		wave_died.connect(_auto_continue)
