extends CharacterBody2D
class_name EnemyCharacter 
const SpeedUnit : float = 1000
var f_health : float = 2
# var f_sound : AudioStreamPlayer2D

@export var f_speed_multiplier : float = 1
@onready var f_target : PlayerCharacter = get_tree().root.get_child(0).get_node( 'PlayerCharacter1' )
@onready var f_sound : AudioStreamPlayer2D = $Sound
@onready var f_world : Node = get_tree().root.get_child(0)

func _init() :
	print( 'EnemyCharacter : init : ', name )

func _ready() -> void :
	print( 'EnemyCharacter : ready : ', name )
	# f_target = owner.get_node( 'PlayerCharacter1' )
	# f_target = get_tree().get_first_node_in_group( 'player' )
	# print_debug( f_target )

func _physics_process( delta : float ) -> void :
	look_at( f_target.position )
	move( delta )

func move( delta : float ) -> void :
	var direction : Vector2 = position.direction_to( f_target.position )
	velocity = direction * SpeedUnit * f_speed_multiplier * delta
	move_and_slide()

func hit( demage : float ) -> void :
	f_health = clamp( f_health - demage, 0.0, 1.0 )
	# print( 'f_health : ', f_health )
	if f_health == 0 :
		death()

func death() -> void :
	if not visible : 
		return 
	f_world.handle_enemy_dead()
	# f_sound = f_sound_prototype.duplicate()
	# self.add_child( f_sound )		
	f_sound.play()
	f_sound.finished.connect( destroy )
	visible = false
	disable_mode = DISABLE_MODE_REMOVE
	# queue_free()

func destroy() -> void :
	# f_sound.queue_free()
	queue_free()
