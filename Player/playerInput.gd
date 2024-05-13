extends MultiplayerSynchronizer

@export var input_vector := Vector2()
@export var attacking = false

func _ready():
	# Only process for the local player.
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	
	
@rpc("call_local")
func attack():
	attacking = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if Input.is_action_just_pressed("Attack"):
		print("we are trying to attack")
		attack.rpc()

func attackingFalse():
	attacking = false
	
