extends Node2D

@onready var player: Player = $Player
@onready var spawnpoint: Node2D = $spawnpoint

@export var monster_scene: PackedScene = preload("res://tscn/monster.tscn")
@export var spawn_mark_scene: PackedScene = preload("res://Art/Character/spawn mark/spawn_mark.tscn")
@export var spawn_radius: float = 1000.0
@export var min_spawn_distance: float = 100.0
@export var spawn_interval: float = 3.0
@export var max_monsters: int = 10
@export var spawn_delay: float = 1.5   # time to show mark before monster spawns

var spawn_timer := 0.0

func _ready() -> void:
	spawnpoint.position = Vector2.ZERO
	player.spawn_point = spawnpoint

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0:
		if get_monster_count() < max_monsters:
			spawn_monster_near_player()
		spawn_timer = spawn_interval

func spawn_monster_near_player() -> void:
	if !player:
		return
	
	var angle = randf() * TAU
	var radius = min_spawn_distance + randf() * (spawn_radius - min_spawn_distance)
	var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * radius
	
	# Create spawn mark first
	var spawn_mark = spawn_mark_scene.instantiate()
	spawn_mark.position = spawn_pos
	add_child(spawn_mark)

	# Delay before spawning monster
	await get_tree().create_timer(spawn_delay).timeout

	# Spawn monster at the same spot
	var monster = monster_scene.instantiate()
	monster.position = spawn_pos
	add_child(monster)
	print(get_monster_count())

	# Remove the spawn mark
	spawn_mark.queue_free()

func get_monster_count() -> int:
	return get_tree().get_nodes_in_group("Monster").size()
