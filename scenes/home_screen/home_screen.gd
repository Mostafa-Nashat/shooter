extends Control


@onready var animation: AnimationPlayer = $AnimationPlayer
@export var card_animations: AnimationPlayer
@export var click_sound: AudioStreamPlayer2D
@onready var savefile_box: VBoxContainer = %savefiles
@export var savefile_button: PackedScene
@export_dir var savefile_path: String


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


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_story_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		click_sound.play()
		animation.play("play_to_story")

func _on_savefile_adder_pressed() -> void:
	var savefile_count := savefile_box.get_child_count()
	click_sound.play()
	var level: Level = Global.default_savefile.scene.instantiate()
	level.savefile = Global.default_savefile
	level.savefile.id = savefile_count
	ResourceSaver.save(level.savefile, Global.savefile_path + "/" + str(level.savefile.id) + ".tres")
	get_tree().change_scene_to_node(level)

func _ready() -> void:
	for file in DirAccess.get_files_at(savefile_path):
		var savefile: SaveFile = load(savefile_path + '/' + file)
		var savefile_button_node = savefile_button.instantiate()
		savefile_button_node.text = str(savefile.id)
		if "savefile" in savefile_button_node:
			savefile_button_node.savefile = savefile
		savefile_box.add_child(savefile_button_node)
		


func _on_back_to_play_pressed() -> void:
	click_sound.play()
	animation.play("story_to_play")
