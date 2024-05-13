extends Area2D



var player = null #just for now 
#setGet does not seem to work in this version of Godot but I've got it more or less figured out. 

func can_see_player():
	return player != null #yeah the logic is fetcher. 
	

func _on_body_entered(body):
	player = body

func _on_body_exited(_body):
	player = null
