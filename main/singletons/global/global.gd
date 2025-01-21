extends Node


func get_active_node() -> Node:
	return get_tree().root.get_child(-1)
