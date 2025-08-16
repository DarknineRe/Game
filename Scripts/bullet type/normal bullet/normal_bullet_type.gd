class_name NormalBulletType

extends CharacterBody2D

@export var speed: float = 800.0
@export var lifetime: float = 2.0
@export var damage := 20.0
@export var knockback_force := 200.0 #unedited
@export var stun_time := 1.5 #unedited
@export var max_pierce := 1
@export var fire_rate := 0.1

@onready var hurtbox = $BulletHitbox

var current_pierce_count := 0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func set_direction_from_rotation(rot: float) -> void:
	direction = Vector2.RIGHT.rotated(rot)

func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()
