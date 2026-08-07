@abstract
class_name Weapon
extends Node2D

@export var weapon: Weapon_data
@export var sprite: Sprite2D
@export var enabled: bool

signal done_using

var started: bool = false

func enable_temp(time: float):
	enabled = true
	await get_tree().create_timer(time).timeout
	enabled = false
	

func _ready() -> void:
	_setup()
	if enabled:
		_start()
		started = true
		visible = true
	else:
		visible = false

func add_sprite(texture: Texture2D, offset: Vector2) -> void:
	sprite.texture = texture
	sprite.position = offset

func _physics_process(_delta: float) -> void:
	if enabled:
		visible = true
		_update()
	else:
		visible = false
		
	if !started and enabled:
		_start()
		started = true


func use(user: Node = null) -> void:
	if enabled:
		visible = true
		await _use(user)
		done_using.emit()
	else: 
		visible = false
	
func _setup():
	pass

func _use(user: Node) -> void:
	pass

func _update() -> void:
	pass

func _start() -> void:
	pass
