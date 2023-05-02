extends CharacterBody2D
class_name PlayerCharacter 
const speed_unit : float = 1000

@export var SpeedMultiplier : float = 5
@export var ProjectileType : PackedScene
@onready var ProjectileMarker : Marker2D = $ProjectileMarker
@onready var f_sound : AudioStreamPlayer2D = $Sound

func _init():
	print( 'PlayerCharacter : init : ', name )

func _ready() -> void:
	print( 'PlayerCharacter : ready : ', name )

func _physics_process( delta : float ) -> void:
	var mouse_position = get_global_mouse_position()
	look_at( mouse_position )
	move( delta )
	shoot( delta )

func move( delta : float ) -> void:
	# print( 'physics ', 1 / delta )
	var movement : Vector2 = Vector2.ZERO
	if Input.is_action_pressed( 'move_left' ): movement.x = movement.x - 1.0 
	if Input.is_action_pressed( 'move_right' ): movement.x = movement.x + 1.0 
	if Input.is_action_pressed( 'move_up' ): movement.y = movement.y - 1.0 
	if Input.is_action_pressed( 'move_down' ): movement.y = movement.x + 1.0 
	#print( 'movement ', movement )
	velocity = movement * speed_unit * SpeedMultiplier * delta
	move_and_slide()

func shoot( _delta : float ) -> void:
	if Input.is_action_just_pressed( 'shoot' ):
		var projectile : Projectile = ProjectileType.instantiate()
		projectile.f_player_character = self
		# ProjectileMarker = get_node( 'ProjectileMarker' )
		var marker = ProjectileMarker 
		# print_debug( marker.global_transform )
		projectile.global_transform = marker.global_transform
		owner.add_child( projectile )
		print( 'shoot' )
		# var sound = get_node( 'Sound' )
		var sound = f_sound.duplicate()
		# self.add_child( sound )
		f_sound.play()
		# f_sound.finished.connect( func() : f_sound.queue_free() )
		#print_debug( f_sound )
