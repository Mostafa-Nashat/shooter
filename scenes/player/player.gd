extends CharacterBody2D

@export var SPEED: float = 60.0

@export var sprite: Sprite2D
@export var ui_manager: UI_manager

@export var gun: Gun
@export var gun_data: Gun_data

func _ready() -> void:
	gun.weapon = gun_data
	ui_manager.set_gun_sprite(gun_data.sprite)
	gun.start()

func _physics_process(delta: float) -> void:
	gun.physics_update(delta)
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	velocity = direction * SPEED
	
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
	
	
	move_and_slide()
