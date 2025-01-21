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
	_play("Main")


func _play(audio_name: String, from_position: float = 0.0) -> void:
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


func fade_out_and_stop(duration: float = 1.0) -> void:
	if not active_music_stream:
		return
	
	var current_music_stream: AudioStreamPlayer = active_music_stream
	var current_volume_db: float = active_music_stream.volume_db
	
	_change_volume(
		current_volume_db,
		MUTE_DB,
		duration,
		func():
			current_music_stream.stop()
			current_music_stream.volume_db = current_volume_db
	)


func _change_volume(
					from: float,
					to: float,
					duration: float = 1.0,
					callback: Callable = func(): return) -> void:
	
	active_music_stream.volume_db = from
	
	var tween: Tween = create_tween()
	tween.tween_property(active_music_stream, "volume_db", to, duration)
	tween.tween_callback(callback)


func play_click_audio() -> void:
	play_audio_one_shot(click_audio, 0, 0.015)


func play_window_audio() -> void:
	play_audio_one_shot(window_audio)
