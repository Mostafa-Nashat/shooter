class_name Frager
extends Enemy

@export var frag_thrower: FragThrower
@export var throw_animation: AnimationPlayer
@export var power: float = 100.0
@export var throw_delay: float = 1.0
@export var wind_up_time: float = 0.5

func _stun() -> void:
	state_machine.switch_state("stun")
