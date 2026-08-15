class_name SurfaceBasedAudioPlayer
extends RefCounted

var path: String
var player: AudioStreamPlayer2D

static func create(audio_path: String, audio_player: AudioStreamPlayer2D) -> SurfaceBasedAudioPlayer:
	var surface_audio_player := SurfaceBasedAudioPlayer.new()
	surface_audio_player.path = audio_path
	surface_audio_player.player = audio_player
	return surface_audio_player

func get_surface_audio(tilemap: TileMapLayer, global_position: Vector2, data_name: String) -> AudioStream:
	var local_position := tilemap.to_local(global_position)
	var map_position := tilemap.local_to_map(local_position)
	var cell_data := tilemap.get_cell_tile_data(map_position)
	if !cell_data:
		print("cell data isnt present")
		return
	if !cell_data.has_custom_data(data_name):
		print("cell does not have requested audio data")
		return
	var audio_data: String = cell_data.get_custom_data(data_name)
	var audio := _get_random_audio_from_directory(audio_data)
	return audio

func play_surface_audio(tilemap: TileMapLayer, global_position: Vector2, data_name: String) -> void:
	var audio := get_surface_audio(tilemap, global_position, data_name)
	if player.playing:
		return
	player.stream = audio
	player.play()

var loaded_streams: Dictionary[String, AudioStream]
func _get_random_audio_from_directory(directory_name: String) -> AudioStream:
	var audio_directory_path := path + directory_name
	var files := DirAccess.get_files_at(audio_directory_path)
	if len(files) == 0:
		return null
	var random_index := randi_range(0, len(files) - 1)
	var random_file := files[random_index]
	var audio_path := audio_directory_path + "/" + random_file
	if loaded_streams.has(audio_path):
		return loaded_streams[audio_path]
	var audio: AudioStream = load(audio_path)
	loaded_streams[audio_path] = audio
	return audio
