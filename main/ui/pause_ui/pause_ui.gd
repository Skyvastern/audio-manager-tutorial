extends Control
class_name PauseUI

@export var reload_btn: Button
@export var exit_btn: Button


func _ready() -> void:
	reload_btn.pressed.connect(_on_reload_btn_pressed)
	exit_btn.pressed.connect(_on_exit_btn_pressed)
	
	get_tree().paused = false
	_on_pause_update()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		_on_pause_update()


func _on_reload_btn_pressed() -> void:
	AudioManager.play_click_audio()
	get_tree().reload_current_scene()


func _on_exit_btn_pressed() -> void:
	AudioManager.play_click_audio()
	get_tree().quit()


func _on_pause_update() -> void:
	visible = get_tree().paused
	
	if get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		AudioManager.play_window_audio()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
