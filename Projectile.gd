extends Area2D
class_name Projectile 
const SpeedUnit : float = 1000
var f_player_character : PlayerCharacter
var f_ttl : float = 10

@export var f_spead_multiplier : float = 1

func _init() -> void :
	body_entered.connect( on_body_entered )  

func _physics_process( delta : float ) -> void:
	move( delta )
	ttl_handle( delta )

func move( delta : float ) -> void:
	# print( 'physics ', 1 / delta )
	# var movement : Vector2 = Vector2.ZERO
	# velocity = movement * speed_unit * SpeedMultiplier * delta
	# move_and_slide()
	position += transform.x * SpeedUnit * f_spead_multiplier * delta

func on_body_entered( body : Node2D ) -> void :
	# print( 'on_body_entered' )
	if body is PlayerCharacter or not body.visible : 
		return
	if body is EnemyCharacter :
		body.hit( 0.4 )
	queue_free()
	
func ttl_handle( delta : float ) -> void :
	f_ttl -= delta
	# print( 'f_ttl : ', f_ttl )
	if f_ttl <= 0 : 
		queue_free()
