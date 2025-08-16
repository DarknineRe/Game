extends Node2D

@export var sprite_offset := Vector2(16, 0) 
@export var sprite_scale := Vector2.ONE     
@export var flip_when_left := true          
@export var gun_sprite: Sprite2D
@export var player : Player = get_owner()           


var can_shoot := true

func _ready() -> void:
	gun_sprite.position = sprite_offset

func _process(_delta: float) -> void:
	if not player:
		return

	var aim_vec = get_global_mouse_position() - player.global_position
	if aim_vec.length() == 0:
		return

	# Rotate pivot so the gun rotates AROUND the player
	global_rotation = aim_vec.angle()
	
	if flip_when_left:
		gun_sprite.flip_v = (cos(global_rotation) < 0)
	
	if Input.is_action_just_pressed("fire") and can_shoot:
		shoot()
		

func shoot() -> void:
	can_shoot = false  # 🔹 block further shooting
	var bullet = preload("res://bullet type/laser bullet/laser_bullet_type.tscn").instantiate()
	for strategy in player.upgrades:
		#strategy.apply_upgrade(bullet)
		pass
	
	bullet.global_position = gun_sprite.global_position
	bullet.global_rotation = global_rotation
	#bullet.set_direction_from_rotation(global_rotation)  # Set movement direction here
	get_tree().current_scene.add_child(bullet)

	# Wait before allowing next shot
	#await get_tree().create_timer(bullet.fire_rate).timeout
	can_shoot = true
