extends AudioStreamPlayer
class_name AudioOneShot

var from_position: float = 0.0


func _ready() -> void:
	finished.connect(self.queue_free)
	play(from_position)
