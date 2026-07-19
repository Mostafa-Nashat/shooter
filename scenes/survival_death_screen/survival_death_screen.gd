extends Control

@export var died_on_wave: int
@export var died_on_wave_label: Label
@export var died_on_wave_prefix: String = "You died on wave "

func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/survival/survival.tscn")

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_screen/home_screen.tscn")

func _ready() -> void:
	if died_on_wave < 0:
		died_on_wave_label.text = "You did this on purpose, didnt you?"
	died_on_wave_label.text = died_on_wave_prefix + str(died_on_wave)
	
	
