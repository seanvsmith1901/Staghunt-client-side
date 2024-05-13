extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.

const GrassEffect = preload("res://Effects/grass_effect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instantiate() #lowercase shows an instance (from the scene make da node)
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position



func _on_hurtbox_area_entered(area):
	#this way whenever something enters its hurtbox its gonna have the effect
	#but only the sword will destroy it
	create_grass_effect()
	if (area.name == "Sword Hitbox"):
		queue_free()
	
	
	# Replace with function body.
