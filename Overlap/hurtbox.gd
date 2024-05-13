extends Area2D

signal invincibility_started
signal invincibility_ended

const HitEffect = preload("res://Effects/hit_effect.tscn")
@onready var timer = get_node("CollisionShape2D/Timer")
@onready var collisionShape = $CollisionShape2D

var invincible = false #just as a default

func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func start_invincibility(duration):
	#timer.connect("on_timer_timeout", self._on_timer_timeout)
	#add_child(timer) #this is VERY VERY important please don't forget it. 
	timer.start(duration)
	set_invincible(true)

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	elif invincible == false:
		emit_signal("invincibility_ended")
	else:
		pass
		
func _on_invincibility_started():
	collisionShape.set_deferred("disabled", true)

func _on_invincibility_ended():
	collisionShape.set_deferred("disabled", false)

func _on_timer_timeout():
	set_invincible(false)
	


