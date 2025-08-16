class_name BulletUpgradeSpeed
extends BulletUpgrade 


@export var damage_mult : float = 1
@export var damage_add : float = 0

func apply_upgrade(bullet: Bullet):
	bullet.damage += damage_add
	bullet.damage *= damage_mult
	
	print("new bullet damage is : " + str(bullet.damage))
