class_name Frag
extends RigidBody2D

@export var direction := Vector2.ZERO
@export var throw_power: float = 50.0
@export var roll_duration: float = 1.0
@export var damage: int = 2
@export var explosion_duration: float = 0.2
@export var hitbox: Area2D
@export var animation: AnimatedSprite2D
@export var sprite: Sprite2D

func _ready() -> void:
	linear_velocity = direction * throw_power
	get_tree().create_timer(roll_duration).timeout.connect(explode)
	if animation:
		animation.visible = false
	ready()

func ready() -> void:
	pass

func explode() -> void:
	if animation:
		animation.visible = true
	if sprite:
		sprite.visible = false
	
	if animation:
		animation.play()
	do_damage()
	var tree := get_tree()
	if tree:
		tree.create_timer(explosion_duration).timeout.connect(queue_free)

func do_damage() -> void:
	for area in hitbox.get_overlapping_areas():
		if area is Hurtbox:
			var hurtbox: Hurtbox = area
			hurtbox.health.damage(damage, self)
