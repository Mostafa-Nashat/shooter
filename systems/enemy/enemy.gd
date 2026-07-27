class_name Enemy
extends CharacterBody2D

@export var SPEED: float = 50 
@export var drops: Array[ItemDrop] = []
@export var drop_speed : float = 200.0

@export_category("Dependencies")
@export var state_machine: State_machine 
@export var arm: Arm
@export var navigator: NavigationAgent2D
@export var health: HealthManager
@export var item_droper: ItemDroper
@export var collision_offset := 60

signal died

func _ready() -> void:
	health.died.connect(_on_died)
	health.damaged.connect(_on_damaged)

func drop_item(drop: ItemDrop, damager: Node2D) -> void:
	item_droper.knock_from(drop.item.data, drop.item.count, damager, drop_speed)


func _on_damaged(_hitpoints: int, damager: Node2D) -> void:
	for drop in drops:
		if drop.weight > 1:
			while drop.weight > 1:
				drop_item(drop, damager)
		if drop.weight > 0:
			var random_number := randf_range(0, 1.0)
			if drop.weight > random_number:
				drop_item(drop, damager)
				
		
func _physics_process(_delta: float) -> void:
	state_machine.update()
	move_and_slide()


func _on_died(_killer: Node2D) -> void:
	queue_free()
	died.emit()

func get_next_direction() -> Vector2:
	var direction := (navigator.get_next_path_position() - global_position).normalized()
	return direction

func go_to(target: Vector2, speed: float) -> void:
	navigator.target_position = target
	var velocity_direction := (navigator.get_next_path_position() - global_position).normalized()
	velocity = velocity_direction * speed
