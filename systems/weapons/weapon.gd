class_name Weapon
extends Node2D

@export var weapon: Weapon_data

var started: bool = false

func enable_temp(time: float):
	weapon.enabled = true
	await get_tree().create_timer(time).timeout
	weapon.enabled = false
	

func _ready() -> void:
	_setup()
	if weapon.enabled:
		_start()
		started = true
		visible = true
	else:
		visible = false

func add_sprite(texture: Texture2D, offset: Vector2) -> void:
	var sprite := Sprite2D.new()
	sprite.texture = texture
	sprite.position = offset
	sprite.visible = true
	add_child(sprite)

func _physics_process(_delta: float) -> void:
	if weapon.enabled:
		visible = true
		_update()
	else:
		visible = false
		
	if !started and weapon.enabled:
		_start()
		started = true


func use(user: Node = null) -> void:
	if weapon.enabled:
		visible = true
		_use(user)
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
