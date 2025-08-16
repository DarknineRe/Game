extends Node

@export var anim : AnimationPlayer
@export var sprite : Sprite2D

@onready var monster : Monster = get_owner()

func _physics_process(_delta: float) -> void:
	if !monster.alive:
		monster.hp_bar.hide()
		anim.play("death")
		await anim.animation_finished
		await get_tree().create_timer(10).timeout
		return
	
	var is_idle = monster.velocity.length() == 0
	var anim_name : String = ""
		
	if is_idle:
		anim_name = "idle"
		
	elif monster.velocity.length() > 0:
		anim_name = "walk"
		
	if monster.velocity.x > 0:
		sprite.flip_h = false
	elif monster.velocity.x < 0:
		sprite.flip_h = true
	else:
		pass

	if monster.stunned:
		anim_name = "hurt"
		anim.play(anim_name)
		return

	if monster.is_attacking:
		anim_name = "attack"
		anim.play(anim_name)
		await anim.animation_finished
		monster.is_attacking = false
		return
		
	anim.play(anim_name)
