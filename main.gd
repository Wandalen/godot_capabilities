extends Node

var wave : int = 0
var enemies_counter : int = 1
var enemies_spawned : int = 1
var enemies_at_wave : int = 1
var enemy_spawn_timer : Timer

@export var enemy_spawn_period : int = 2
@onready var EnemyCharacterScene : PackedScene = load( 'res://EnemyCharacter.tscn' )

func _init() -> void:
	enemy_spawn_timer = Timer.new()
	enemy_spawn_timer.wait_time = enemy_spawn_period
	enemy_spawn_timer.one_shot = false
	enemy_spawn_timer.timeout.connect( handle_spawn )
	add_child( enemy_spawn_timer )

func _process( delta ) :
	if Input.is_action_pressed( "ui_cancel" ) :
		get_tree().quit()

func handle_spawn() -> void :
	if enemies_spawned >= enemies_at_wave :
		enemy_spawn_timer.stop()
		return
	var zones = get_node( 'EnemySpawnZones' )
	var global_transform = zones.get_child( randi_range( 0, zones.get_child_count() - 1 ) ).global_transform
	var enemy : EnemyCharacter = EnemyCharacterScene.instantiate()
	enemy.global_transform = global_transform
	self.add_child( enemy )
	print( 'added' )
	enemies_counter += 1
	enemies_spawned += 1
	# print( 'global_transform : ', global_transform )

func handle_enemy_dead() -> void :
	enemies_counter -= 1
	if enemies_counter > 0 or enemies_spawned < enemies_at_wave :
		return
	enemies_at_wave *= 2
	enemies_spawned = 0
	wave += 1
	enemy_spawn_timer.start()
