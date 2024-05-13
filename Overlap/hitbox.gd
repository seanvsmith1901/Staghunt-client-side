extends Area2D


@export var damage = 3 #default

func set_damage(value):
	damage = value
	
func get_damage():
	return damage
