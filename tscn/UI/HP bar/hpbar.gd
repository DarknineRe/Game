class_name HPbar
extends ProgressBar


@export var iframe := false
@export var timer2 := 1.0
@export var HPnode : Health

@onready var timer = $Timer
@onready var damgae_bar = $DamageBar
@onready var hp = HPnode.health

var player : Player = get_owner()


func _ready() -> void:
	HPnode.health_changed.connect(change_health)
	init_health(hp)
	
func change_health(HP) -> void:
	_set_health(HP)
	
func _set_health(new_hp: float) -> void:
	var prev_hp = hp
	hp = clamp(new_hp, 0, max_value)
	value = hp
	var hp_percent = float(hp) / max_value
	
	# Get the shared style first
	var fill_style = get("theme_override_styles/fill")
	# If fill_style exists, create a unique copy for this instance
	if fill_style:
		# If we don't already have a unique style, duplicate it
		
		fill_style = fill_style.duplicate()
		set("theme_override_styles/fill", fill_style)
		
		# Now modify the color on this unique style copy
	if hp_percent <= 0.2:
		fill_style.bg_color = Color.RED
	elif hp_percent <= 0.5:
		fill_style.bg_color = Color.YELLOW
	else:
		fill_style.bg_color = Color.LIME  # Or default green

	if hp < prev_hp:
		timer.start()
	else:
		damgae_bar.value = hp



func init_health(_hp: int) -> void:
	hp = _hp
	max_value = _hp
	value = _hp
	damgae_bar.max_value = _hp
	damgae_bar.value = _hp

func _on_timer_timeout() -> void:
	damgae_bar.value = hp
	
