extends CharacterBody2D


@onready var sprite = $Sprite2D
@onready var hurtbox = $Hurtbox

#this needs to be a server call as well. 
var Spider_Points = Gamedata.Spider_Points

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

func _ready():

	#sprite.flip_h
	var stateList = [RUN]
	state = pick_new_state(stateList)


func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()
	
	
	match state:
		
		RUN: 
			var direction = Vector2.RIGHT
			#direction = direction.normalized() #I'm not sure if we need this but I figure it can't hurt. 
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION) 	
	move_and_slide()
			

func pick_new_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

	
func _on_stats_zero_health():
	
	queue_free()



func _on_hurtbox_area_entered(area):
	if (area.name == "SpiderDetection"):
		Gamedata._increase_score(Spider_Points)
		hurtbox.create_hit_effect()
		queue_free()
	
		

func player_attack():
	#stats.set_health(0)
	hurtbox.create_hit_effect()
	_on_stats_zero_health()
	

