class_name Level
extends Node2D


@export var ground_layer: TileMapLayer
@export var audio_player: AudioStreamPlayer
@export var player: Player



func play(steam: AudioStream, volume: float) -> void:
	audio_player.play()
	var playback: AudioStreamPlaybackPolyphonic = audio_player.get_stream_playback()
	playback.play_stream(steam, 0, volume)

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	player.died.connect(get_tree().reload_current_scene)
