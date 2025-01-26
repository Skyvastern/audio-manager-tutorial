extends Node

var active_music_stream: AudioStreamPlayer
const MUTE_DB: float = -50

@export_group("Main")
@export var audio_one_shot_scene: PackedScene
@export var clips: Node
@export var one_shots: Node

@export_group("Extras")
@export var click_audio: AudioStream


func play(audio_name: String, from_position: float = 0.0, skip_restart: bool = false) -> void:
	if skip_restart and active_music_stream and active_music_stream.name == audio_name:
		return
	
	active_music_stream = clips.get_node(audio_name)
	active_music_stream.play(from_position)


func play_audio_one_shot(audio_stream: AudioStream, volume_db: float = 0.0, from_position: float = 0.0) -> AudioOneShot:
	var audio_one_shot: AudioOneShot = audio_one_shot_scene.instantiate()
	audio_one_shot.stream = audio_stream
	audio_one_shot.volume_db = volume_db
	audio_one_shot.from_position = from_position
	
	one_shots.add_child(audio_one_shot)
	return audio_one_shot


func play_click_audio() -> void:
	play_audio_one_shot(click_audio, 0, 0.015)
