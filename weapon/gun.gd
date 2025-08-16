
class_name Gun
extends Resource

@export var texture: Texture2D
@export var bullet_speed: float = 800.0
@export var bullet_lifetime: float = 2.0
@export var damage: float = 20.0
@export var knockback_force: float = 200.0
@export var stun_time: float = 1.5
@export var max_pierce: int = 1
@export var fire_rate: float = 3.0

@export var bullet_type: BulletType
