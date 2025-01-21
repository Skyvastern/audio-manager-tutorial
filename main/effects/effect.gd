extends CPUParticles2D
class_name CustomEffect


func _ready() -> void:
	finished.connect(func(): queue_free())


func set_particle_color(particle_color: Color) -> void:
	color = particle_color
