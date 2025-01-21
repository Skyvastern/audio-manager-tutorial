extends AudioStreamPlayer
class_name AudioOneShot

var play_from: float = 0.0


func _ready() -> void:
	finished.connect(self.queue_free)
	play(play_from)
