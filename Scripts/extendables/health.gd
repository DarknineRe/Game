class_name Health
extends Node

signal health_changed(health: float)

@export var max_health := 100.0

@export_group("Link Node")
@export var hitbox : Hitbox

@onready var health := max_health
@onready var unit = get_owner()

func on_damaged(attack: Attack):
	if !unit.alive:
		return
	
	health -= attack.damage
	
	health_changed.emit(health)
	
	if health <= 0:
		health = 0
		unit.alive = false
