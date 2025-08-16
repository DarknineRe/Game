extends MonsterState


var timer : Timer


# Upon moving to this state, initialize timer
# and stun enemy

func enter():
	print("dead")
	var exp1 = preload("res://tscn/exp.tscn").instantiate()
	exp1.global_position = enemy.global_position  # Set movement direction here
	get_tree().current_scene.add_child(exp1)
	
	await enemy.anim_player.animation_finished
	enemy.queue_free()
