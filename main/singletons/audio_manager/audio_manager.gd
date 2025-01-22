extends Node

var active_music_stream: AudioStreamPlayer
const MUTE_DB: float = -50

@export_group("Main")
@export var audio_one_shot_scene: PackedScene
@export var clips: Node
@export var one_shots: Node

@export_group("Extras")
@export var click_audio: AudioStream
@export var window_audio: AudioStream


func _ready() -> void:
	play("Main")


func play(audio_name: String, from_position: float = 0.0) -> void:
	if active_music_stream:
		if active_music_stream.name == audio_name:
			return
		
		if active_music_stream.playing:
			active_music_stream.stop()
	
	active_music_stream = clips.get_node(audio_name)
	active_music_stream.play(from_position)


func play_audio_one_shot(audio_stream: AudioStream, volume_db: float = 0.0, play_from: float = 0.0) -> AudioOneShot:
	var audio_one_shot: AudioOneShot = audio_one_shot_scene.instantiate()
	audio_one_shot.stream = audio_stream
	audio_one_shot.volume_db = volume_db
	audio_one_shot.play_from = play_from
	
	one_shots.add_child(audio_one_shot)
	return audio_one_shot


func play_click_audio() -> void:
	play_audio_one_shot(click_audio, 0, 0.015)


func play_window_audio() -> void:
	play_audio_one_shot(window_audio)
