class_name Monster
extends CharacterBody2D
signal damaged(attack: Attack)
@export var chase_radius := 1000.0
@export var chase_speed := 100.0
@export var attack_range := 75.0
@export var detection_radius := 100.0
@export var follow_radius := 25.0
var is_attacking := false
var alive := true
var stunned := false
var stun_time := 1.5
var knockback_force := 200.0
var knockback_velocity: Vector2 = Vector2.ZERO

@onready var health: Health = $Health
@onready var hp_bar:= $Hpbar
@onready var player: CharacterBody2D = null
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hp_bar.hide()

func _physics_process(_delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
		if player == null:
			return  # No player found

func on_damaged(attack: Attack) -> void:
	hp_bar.show()
	damaged.emit(attack)
	
