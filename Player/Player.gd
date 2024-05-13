extends CharacterBody2D

#comments time
#note: velocity is already defined under characterBody2d which is why its never declared

#some consts for movement. 
@export var FRICTION = 20
@export var MAX_SPEED = 100 
@export var ACCELERATION = 5
@export var ROLL_SPEED = 150
@export var INVICIBILITY_TIME = 1 #time in seconds
const ROLL_TIME = 0.05
#const BUTTONPRESSTIME = 0.02
const BUTTONPRESSTIME = 1
var playerState


#@onready var input_vector = $playerInput.input_vector

@export var player := 1 :
	set(id):
		player = id
		print("we are attempting to use the right id, right? ", id)
		set_multiplayer_authority(id, true)
		#the above does the same thing but just here instead of there
		#$playerInput.set_multiplayer_authority(id)





#different point values for different creatures pulled from the Json
var Spider_Points = Gamedata.Spider_Points
var Bat_Points = Gamedata.Bat_Points


@onready var timer = get_node("Timer")


const PlayerHurtSound = preload("res://Player/player_hurt_sound.tscn")



enum {
	ATTACK, 
	MOVE
}

var state = MOVE
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")





#make sure to use @onready instead of normal onready.
	

#this should make all of the player input pass throuhg the synchronizer	
	
func _ready():
	DefinePlayerState()
	animationTree.active = true
	
	
	
	
	#no idea if this will help or work
	

	#makes the animation tree active on startup. 
	
	#so our sword hitbox was alwasy on when we started so I manually disabled it here 
	#gets turned on during the animation player for every animation. 

		
func _physics_process(_delta):
	
	var input_vector = $playerInput.input_vector
	velocity = input_vector * MAX_SPEED
	#print(velocity)
	move_state()
	if $playerInput.attacking:
		attack_state()
		#gets set to false when the animation finishes. is it stupid? Yes!
		#does it work for right now? sure why note



func move_state():
	var input_vector = $playerInput.input_vector
	#ok so the input vector is under player input and then we just calculate the velocity and whatnot here. 
	
	
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationTree.set("parameters/Attack/blend_position", input_vector)
	animationTree.set("parameters/Roll/blend_position", input_vector)
	animationState.travel("Run")

		
		
	#options for changing our current state (state machine time)
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK 
	move()




func attack_state():
	
	animationState.travel("Attack")
	#we changed from a player oriented detection system to a global varaible, make it work. 
	#get_node("BatDetection/DetectionShape").disabled = false
	
	#not really sure why I have these in two seperate funcitons
	#it made sense when I wrote it so we are going to leave it that way. 
	Gamedata.enableBatDetection()
	Gamedata.enableSpiderDetection()
	#get_node("SpiderDetection/CollisionShape2D").disabled = false
	timer.start(BUTTONPRESSTIME)
	
	
	
func attackAnimationFinished():
	print("animation finished")
	state = MOVE
	if $playerInput.attacking == true:
		$playerInput.attacking = false
	#determines how much slide we have afterward.  
	

func move():
	move_and_slide()
	
func _on_hurtbox_area_entered(area):
	var hitBoxName = area.get_parent().name
	if hitBoxName.find("Grass", 0): #So if it is false we continue
		var playerHurtSounds = PlayerHurtSound.instantiate()
		get_tree().current_scene.add_child(playerHurtSounds)
		
	else:
		pass
	
func _on_animal_detection_area_entered(area):
	#if the player decides to do something
	pass
		
		
	
func _on_timer_timeout():
	Gamedata.disableDetection()
	if $playerInput.attacking == true:
		print('stop attacking"')
		$playerInput.attacking = false
	#print("stopping attacking")
	


func _on_spider_detection_area_entered(area):
	if (area.name == "Hurtbox"):
		area.get_parent().player_attack()
		print("SPIDER SPIDER SPIDER")
		Gamedata._increase_score(Spider_Points)


func _on_bat_detection_area_entered(area):
	if (area.name == "Hurtbox"):
		area.get_parent().player_attack()
		print("BAT BAT BAT")
		Gamedata._increase_score(Bat_Points)
		
func DefinePlayerState():
	pass
	#playerState = {"T": Time.get_unix_time_from_system(), "P": get_global_position()}
	#print(playerState)
	#ServerMaster.SendPlayerState(playerState)
