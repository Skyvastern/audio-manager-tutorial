extends Area2D
class_name Bullet

@export_group("Main")
@export var speed: float = 1000

@export_group("Effect")
@export var impact_effect_scene: PackedScene
@export var impact_effect_color: Color = Color.WHITE

@export_group("References")
@export var visibility_notifier: VisibleOnScreenNotifier2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	visibility_notifier.screen_exited.connect(_on_screen_exited)


func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_body_entered(_body: Node2D) -> void:
	_destroy()


func _on_screen_exited() -> void:
	_destroy()


func _destroy() -> void:
	var impact_effect: CustomEffect = impact_effect_scene.instantiate()
	
	Global.get_active_node().add_child(impact_effect)
	impact_effect.global_position = global_position
	impact_effect.global_rotation = global_rotation
	
	impact_effect.set_particle_color(impact_effect_color)
	impact_effect.emitting = true
	
	queue_free()
