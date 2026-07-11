class_name Enemy
extends CharacterBody2D

@export var health_manager: Health_manager
@export var health: int = 2

func _ready() -> void:
	health_manager.set_health(health)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet: Bullet = area
		var is_dead := health_manager.damage(bullet.bullet.damage)
		if is_dead:
			queue_free()
		area.queue_free()
