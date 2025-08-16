class_name Movement
extends Node



@export var player : Player 
@export var stamina_bar : ProgressBar

@export_group("Speed System")
var sprint_speed_mult = 1.4
@export var base_speed := 400.0
@export var acceleration_time := 0.1

@export_group("Stamina System")
@export var Stamina: float = 100
@export var stamina_drain_rate = 20.0
@export var stamina_regen_rate = 10.0

@export_group("Dash System")
@export var dash_speed_mult = 3.0
@export var dash_duration = 0.2
@export var dash_cooldown = 1.0
@export var dash_timer = 0.0
@export var dash_cooldown_timer = 0.0
@export var dash_direction = Vector2.ZERO
@export var is_dashing = false
@export var dash_stamina_cost = 20



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player.alive == false:
		return
	
	# If player is stunned, skip movement input
	#if player.stunned:
		#player.velocity = player.knockback_velocity
		#player.knockback_velocity = player.knockback_velocity.move_toward(Vector2.ZERO, 1000 * delta)
		#player.move_and_slide()
		#return
	
	var input_vector = Input.get_vector("left", "right", "up", "down")

	handle_dash(input_vector, delta)
	handle_sprint(input_vector, delta)
	
	player.move_and_slide()
	
	

func handle_sprint(input_vector: Vector2, delta: float) -> void:
	if is_dashing:
		return  # skip sprinting while dashing

	var speed = base_speed
	var is_sprinting = Input.is_action_pressed("run") and Stamina > 0

	if is_sprinting and input_vector != Vector2.ZERO:
		speed *= sprint_speed_mult
		Stamina = max(Stamina - stamina_drain_rate * delta, 0)
	else:
		Stamina = min(Stamina + stamina_regen_rate * delta, 100)

	# Always update stamina bar after changing stamina
	stamina_bar._set_stamina(Stamina)

	player.velocity = input_vector * speed

# ---------------------------
# Dash Handling
# ---------------------------
func handle_dash(input_vector: Vector2, delta: float) -> void:
	# Cooldown timer
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Start dash
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0 and Stamina >= dash_stamina_cost and input_vector != Vector2.ZERO:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		dash_direction = input_vector
		Stamina -= dash_stamina_cost
		stamina_bar._set_stamina(Stamina)

	# Update dash
	if is_dashing:
		player.velocity = dash_direction * base_speed * dash_speed_mult
		dash_timer -= delta
		stamina_bar._set_stamina(Stamina)
		if dash_timer <= 0:
			is_dashing = false
