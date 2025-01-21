extends Node2D
class_name Gun

const BLEND_TIME: float = 0.5

@export_group("Bullet")
@export var bullet_scene: PackedScene
@export var firepoint: Node2D
@export var muzzle_audio: AudioStream

@export_group("References")
@export var anim_player: AnimationPlayer



func _ready() -> void:
	anim_player.animation_finished.connect(_on_anim_finished)


func shoot() -> void:
	anim_player.play("shoot")


func launch_bullet() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	
	Global.get_active_node().add_child(bullet)
	bullet.global_position = firepoint.global_position
	bullet.global_rotation = firepoint.global_rotation
	
	AudioManager.play_audio_one_shot(muzzle_audio, -15)


func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		anim_player.play("idle", BLEND_TIME)
