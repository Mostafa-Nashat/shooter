class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 50 
@export var MAX_HAND_SWING_SPEED: float = 20

@export var state_machine: State_machine 
@export var arm: Arm
@export var gun: Gun
@export var navigator: NavigationAgent2D
@export var shooting_cooldown: float = 0.75

func _ready() -> void:
	state_machine.default_state("chasing")
	

func _physics_process(_delta: float) -> void:
	state_machine.update()
	move_and_slide()


func _on_died() -> void:
	queue_free()
