extends MonsterState


func physics_process_state(_delta: float):
	if enemy.alive:
		var direction := player.global_position - enemy.global_position
	
		var distance = direction.length()
		if distance > enemy.chase_radius:
			transitioned.emit(self, "idle")
			return
	
		enemy.velocity = direction.normalized()*enemy.chase_speed
	
		if distance <= enemy.follow_radius:
			enemy.velocity = Vector2.ZERO
	
		enemy.move_and_slide()
		if distance <= enemy.attack_range and not enemy.is_attacking:
			enemy.is_attacking = true
			transitioned.emit(self, "attack")
	else:
		transitioned.emit(self, "death")
