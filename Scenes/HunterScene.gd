extends Node2D

var playerCharacter = preload("res://Player/player.tscn")
var connectedPeers = []


#func add_player(playerID, spawnPosition):
	#print("does this signal get emmited?")
	#SpawnNewPlayer(playerID, spawnPosition)
	

#func SpawnNewPlayer(playerID, spawnPosition):
	
	#print("are we getting in here")
	#var new_player = playerCharacter.instantiate()
	#new_player.position = spawnPosition
	#new_player.name = str(playerID)
		#print("the new player name", new_player.name)
		#print("the playe position", new_player.position)
		#print(new_player.name)
		#get_node("playerGroup").add_child(new_player)
		#get_tree().current_scene.add_child(new_player)
	#$playerGroup.add_child(new_player, true)
		#why is this not adding things correctly 
		#print("does all this go down the way that it needs to?")
	
#func despawnPlayer(playerID):
	#if not $playerGroup.has_node(str(playerID)):
		#return
	#$playerGroup.get_node(str(playerID)).queue_free()
