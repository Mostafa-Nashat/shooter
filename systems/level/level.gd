class_name Level
extends Node2D


@export var ground_layer: TileMapLayer
@export var audio_player: AudioStreamPlayer
@export var level_transition: Area2D
var savefile: SaveFile
var player: Player
var reset_scene := PackedScene.new()

func play(steam: AudioStream, volume: float) -> void:
	audio_player.play()
	var playback: AudioStreamPlaybackPolyphonic = audio_player.get_stream_playback()
	playback.play_stream(steam, 0, volume)

func save(location: Node):
	if location is Level:
		savefile.update_save_file(player)
		var scene := PackedScene.new()
		scene.pack(location)
		savefile.scene = scene
		print(location.to_string())
		location.savefile = savefile
		ResourceSaver.save(savefile, Global.savefile_path + str(savefile.id) + ".tres")

func _on_player_died() -> void:
	get_tree().change_scene_to_packed(reset_scene)
	print("died")
	

func _ready() -> void:
	reset_scene.pack(get_tree().current_scene)
	if level_transition:
		level_transition.connect("transition", save)
	player = get_tree().get_first_node_in_group("player")
	if player:
		if !savefile:
			savefile = Global.default_savefile
		savefile.apply_save(player)
		player.died.connect(_on_player_died)
