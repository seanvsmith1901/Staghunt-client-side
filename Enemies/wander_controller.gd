extends Node2D

@export var wander_range = 32


@onready var timer = get_node("Timer")
@onready var start_position = global_position #this will never change. 
@onready var target_position = global_position #this WILL change relative to the start position
@onready var ttimer = $Timer #idk if I will need this lol. 

func _ready():
	update_target_position()

func update_target_position():
	var target_vector = Vector2(randf_range(-wander_range,wander_range), randf_range(-wander_range,wander_range))
	target_position = start_position + target_vector #is always relative to the start poisition
													#what happens if I lead the fetcher away?

func get_time_left():
	return timer.time_left
	
func pause_timer():
	timer.stop()

func start_wander_timer(duration):
	timer.start(duration)

func _on_timer_timeout():
	update_target_position()
	
