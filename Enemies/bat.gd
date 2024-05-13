extends CharacterBody2D


#@onready var playerDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite2D
const EnenmyDeathEffect = preload("res://Effects/enemy_death_effect.tscn")
@onready var hurtbox = $Hurtbox
@onready var softCollision = $SoftCollision
#@onready var wanderController = $WanderController
#@onready var animationPlayer = $AnimationPlayer

#this now needs to be a server call
var Bat_Points = Gamedata.Bat_Points

#these are the same as the player stats but we can change those as necessary. 
@export var FRICTION = 200
@export var MAX_SPEED = 30 
@export var ACCELERATION = 4

signal batInBox

enum {
	IDLE, 
	RUN
	
}

var friction
var state = RUN
var entered = false

#func _ready():

	#animationPlayer.play("Stop")
	#var stateList = [RUN]


func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	match state:
		RUN: 
			var direction = Vector2.RIGHT
			#direction = direction.normalized() #I'm not sure if we need this but I figure it can't hurt. 
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
			sprite.flip_h = velocity.x < 0
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 800
		#higher values less likely to overlap. 
		
	move_and_slide()
		
	
func _on_stats_zero_health():
	var enemyDeathEffect = EnenmyDeathEffect.instantiate() #lowercase shows an instance (from the scene make da node)
	var world = get_tree().current_scene
	world.add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	queue_free()


func _on_hurtbox_area_entered(area):
	#print(area.name)
	if (area.name == "BatDetection"):
		Gamedata._increase_score(Bat_Points)
		hurtbox.create_hit_effect()
		queue_free()
	
	
func player_attack():
	hurtbox.create_hit_effect()
	_on_stats_zero_health()
	
