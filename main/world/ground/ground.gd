@tool
extends StaticBody2D
class_name Ground

@export_enum("Top", "Middle") var ground_type: String = "Top":
	get:
		return ground_type
	set(value):
		ground_type = value
		
		if ground_tr:
			if ground_type == "Top":
				ground_tr.texture = ground_top
			
			elif ground_type == "Middle":
				ground_tr.texture = ground_middle

@export_group("Textures")
@export var ground_tr: Sprite2D
@export var ground_top: Texture2D
@export var ground_middle: Texture2D
