extends Node

@export var anim : AnimatedSprite2D
@export var player : Player 

func _physics_process(_delta: float) -> void:
	if player.alive == false:
		return
	
	var anim_name : String = ""
	
	var input_vector = Input.get_vector("left", "right", "up", "down")
	var is_idle = input_vector == Vector2.ZERO
	var is_horizontal = abs(input_vector.x) > abs(input_vector.y)

	
	if is_idle:
		anim_name = "idle"
	elif is_horizontal:
		anim.flip_h = input_vector.x < 0
		anim_name = "run_side"
	else:
		anim.flip_h = false
		anim_name = ("run_down" if input_vector.y > 0 else "run_up")
	if player.stunned:
		anim_name = "Hurt"
		anim.play(anim_name)
		await anim.animation_finished
		player.stunned = false
		return
	anim.play(anim_name)
