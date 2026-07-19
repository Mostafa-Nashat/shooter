extends Control

@export var enemies_left: int = 0
@export var wave: int = 0
@export var enemy_counter_prefix: String = "Enemies left: "
@export var wave_prefix: String = "Wave: "
@export var enemy_counter: Label
@export var wave_counter: Label

func _process(_delta: float) -> void:
	enemy_counter.text = enemy_counter_prefix + str(enemies_left)
	wave_counter.text = wave_prefix + str(wave)
