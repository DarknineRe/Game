class_name BulletUpgradeSpeed
extends BulletUpgrade

@export var speed_add : float = 0
@export var speed_mult : float = 1

func apply_upgrade(bullet: Bullet):
	bullet.speed += speed_add
	bullet.speed *= speed_mult
	
	print("new bullet speed is : " + str(bullet.speed))
