class_name Blader
extends Enemy

@export var sword: Sword
@export var attack_radius: float

func _stun() -> void:
	state_machine.switch_state("stun")
