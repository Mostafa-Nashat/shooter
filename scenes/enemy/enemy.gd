class_name Enemy
extends CharacterBody2D

@export var health_manager: Health_manager
@export var health: int = 2
@export var SPEED: float = 50 
@export var state_machine: State_machine 
@export var arm: Arm
@export var gun: Gun
@export var navigator: NavigationAgent2D

func _ready() -> void:
	health_manager.set_health(health)
	state_machine.default_state("chasing")
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet: Bullet = area
		var is_dead := health_manager.damage(bullet.bullet.damage)
		if is_dead:
			queue_free()
		area.queue_free()

func _physics_process(_delta: float) -> void:
	state_machine.update()
	move_and_slide()
