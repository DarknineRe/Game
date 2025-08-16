class_name StaminaBar
extends ProgressBar


@export var iframe := false
@export var timer2 := 1.0
@export var StaminaNode : Movement

@onready var timer = $Timer
@onready var damage_bar = $DamageBar 
@onready var stamina = StaminaNode.Stamina

var player : Player = get_owner()

func _ready() -> void:
	init_stamina(stamina)
	
	
func _process(_delta: float) -> void:
	#_set_stamina(stamina)
	pass

func _set_stamina(new_stamina: float) -> void:
	var prev_stamina = stamina
	stamina = clamp(new_stamina, 0, max_value)
	value = stamina
	
	if stamina != prev_stamina:
		# Start delayed update for the "damage" bar effect
		timer.start()

func init_stamina(_sta: float) -> void:
	stamina = clamp(_sta, 0, _sta)
	max_value = _sta
	value = _sta
	#damage_bar.max_value = _sta
	#damage_bar.value = 0
