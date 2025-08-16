class_name EXPbar
extends ProgressBar

@export var current_exp: int = 0
@export var exp_to_next_level: int = 100
@export var level: int = 1

signal level_up(new_level: int)

func _ready() -> void:
	_update_bar()

# Add EXP and check for level-up
func add_exp(amount: int) -> void:
	current_exp += amount
	if current_exp >= exp_to_next_level:
		current_exp -= exp_to_next_level
		level += 1
		emit_signal("level_up", level)
		# Increase requirement for next level (can be adjusted)
		exp_to_next_level = int(exp_to_next_level * 1.2)
	_update_bar()

# Internal: updates progress bar
func _update_bar() -> void:
	max_value = exp_to_next_level
	value = current_exp

	# Optional color change for visual flair
	var percent = float(current_exp) / exp_to_next_level
	var fill_style = get("theme_override_styles/fill")
	if fill_style:
		fill_style = fill_style.duplicate()
		set("theme_override_styles/fill", fill_style)
		if percent < 0.33:
			fill_style.bg_color = Color.LIME
		elif percent < 0.66:
			fill_style.bg_color = Color.YELLOW
		else:
			fill_style.bg_color = Color.CYAN
