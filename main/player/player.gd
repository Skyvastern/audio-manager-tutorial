extends CharacterBody2D
class_name Player

@export_group("Movement & Jump")
@export var speed: float = 1000
@export var jump_speed: float = 1500
@export var gravity: float = 3000

@export_group("References")
@export var anim_player: AnimationPlayer

@export_group("Attack")
@export var weapon_holder: Node2D
@export var gun: Gun


func _physics_process(delta: float) -> void:
	# Movement and Jump
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= jump_speed
	else:
		velocity.y += gravity * delta
	
	var horizontal_input: float = Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left")
	velocity.x = horizontal_input * speed
	
	move_and_slide()
	
	# Animation
	if velocity.y != 0:
		anim_player.play("in_air", 1)
	elif velocity.length() > 0:
		anim_player.play("move", 1)
	else:
		anim_player.play("idle", 1)
	
	# Attack
	var mouse_pos: Vector2 = get_global_mouse_position()
	var weapon_dir: Vector2 = weapon_holder.global_position.direction_to(mouse_pos)
	var aim_angle: float = Vector2.RIGHT.angle_to(weapon_dir)
	weapon_holder.rotation = aim_angle
	
	if Input.is_action_pressed("attack"):
		gun.shoot()
