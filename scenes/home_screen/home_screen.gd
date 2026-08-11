extends Control


@onready var animation: AnimationPlayer = $AnimationPlayer
@export var card_animations: AnimationPlayer
@export var click_sound: AudioStreamPlayer2D

var survival := preload("res://scenes/survival/survival.tscn")

func _on_button_pressed() -> void:
	click_sound.play()
	animation.play("main_to_play")

func _on_survival_mouse_entered() -> void:
	click_sound.play()
	card_animations.play("survival_hover_up")


func _on_survival_mouse_exited() -> void:
	card_animations.play("survival_hover_down")


func _on_story_mouse_entered() -> void:
	click_sound.play()
	card_animations.play("story_hover_up")


func _on_story_mouse_exited() -> void:
	card_animations.play("story_hover_down")


func _on_survival_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		click_sound.play()
		get_tree().change_scene_to_packed(survival)


func _on_back_pressed() -> void:
	click_sound.play()
	animation.play("play_to_main")
