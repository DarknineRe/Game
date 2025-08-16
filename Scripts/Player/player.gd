class_name Player
extends CharacterBody2D

signal respawned
signal damaged(attack: Attack)

var alive = true
var is_running = false #
var has_weapon = false #
var aim_position: Vector2 = Vector2(1, 0)
var stunned = false #

var upgrades : Array[BulletUpgrade] = []


@export var spawn_point: Node2D
@onready var health_node: Health = $Health
@onready var hp_bar = $Hpbar
@onready var anim = $Body
@onready var exp_bar = $ExpBar

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)

func _physics_process(_delta: float) -> void:
	if not alive:
		_play_death_and_respawn()
		return

func kill() -> void:
	if alive:
		_play_death_and_respawn()

func _play_death_and_respawn() -> void:
	alive = false
	anim.play("death")
	await anim.animation_finished

	await get_tree().create_timer(0.1).timeout
	global_position = spawn_point.global_position
	alive = true
	health_node.health = health_node.max_health
	hp_bar._set_health(100)
	emit_signal("respawned")

func on_damaged(attack: Attack) -> void:
	stunned = true
	damaged.emit(attack)

#TODO Just make this shit in the exp.tscn twin
func _on_player_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Exp"):
		exp_bar.add_exp(area.experience)
		area.queue_free()
