class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 50 

@export var state_machine: State_machine 
@export var arm: Arm
@export var navigator: NavigationAgent2D
@export var health: HealthManager

signal died

func _ready() -> void:
	health.died.connect(_on_died)
	

func _physics_process(_delta: float) -> void:
	state_machine.update()
	move_and_slide()


func _on_died() -> void:
	queue_free()
	died.emit()

func get_next_direction() -> Vector2:
	var direction := (navigator.get_next_path_position() - global_position).normalized()
	return direction

func go_to(target: Vector2, speed: float) -> void:
	navigator.target_position = target
	var velocity_direction := (navigator.get_next_path_position() - global_position).normalized()
	velocity = velocity_direction * speed
