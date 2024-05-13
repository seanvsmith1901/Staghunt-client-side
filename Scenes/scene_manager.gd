extends Node

var lvl1 = preload("res://Scenes/Level1.tscn")
var level1 = lvl1.instantiate()
var lobby = preload("res://Scenes/lobby.tscn")
var Lobby = lobby.instantiate()


var clientID

#var Spider = "res://Enemies/giantEnemySpider.tscn"
#var spider = Spider.insantiate()
#var Bat = "res://Enemies/bat.tscn"
#var bat = Bat.insantiate()
@onready var lobbyVisibility = get_node("levelGroup/Lobby")


func _ready():
	SceneMaster.connect("warmingUp", self.initialize)
	SceneMaster.connect("spawnNewPlayer", self.spawnNewPlayer)
	SceneMaster.connect("addNewEnemies", self.addNewEnemies)
	Lobby.connect("deleteLobby", self.deleteLobby)
	SceneMaster.connect("deleteMenu", self.deleteMenu)

func initialize(currentConnectedPlayers, playerID):
	var playerPosition
	#print("we have entered the initalize function now")
	
	# Spawn already connected players.
	print("currentConnectedPlayers.size() ", currentConnectedPlayers.size())
	#removes all the old children, should prevent duplication
	var childrenNumber = $playerGroup.get_child_count()
	for i in $playerGroup.get_children():
		$playerGroup.remove_child(i)
		i.queue_free()
		
	for i in range(currentConnectedPlayers.size()):
		
		if i == 0:
			playerPosition = Vector2(279, 296)
		elif i == 1:
			playerPosition = Vector2(344, 296)
		elif i == 2:
			playerPosition = Vector2(344, 169)
		elif i == 3:
			playerPosition = Vector2(279, 169)
		else:
			playerPosition = Vector2(311, 234)
		
		print("adding player")
		spawnNewPlayer(currentConnectedPlayers[i], playerPosition)
		
		
		
		#TODO: put all of these into gamedata and make it an accesible list, for code clarity and maitenence
	
func _on_button_pressed():
	print("so it was this fetcher going off hjuh")
	##$MainMenu.queue_free()
	

func deleteLobby():
	Lobby.queue_free()


	
	
func spawnNewPlayer(playerID, spawnPosition):
	#print("do we enter this call?")
	#print("we are spawning a new player. lets see how this goes")
	var newPlayer = preload("res://Player/player.tscn").instantiate()
	clientID = playerID
	newPlayer.player = playerID
	#did this do the trick?
	newPlayer.position = spawnPosition
	newPlayer.name = str(playerID)
	
	#set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	#call_deferred("set_multiplayer_authority", playerID)
	#print("checking for duplicates")
	#print(newPlayer.player, newPlayer.position)
	$playerGroup.add_child(newPlayer, true)
	#print("we should have added a player at...")
	#print("name ", newPlayer.name)
	#print("poistion ", newPlayer.position)

func addNewEnemies():
	pass
	
func deleteMenu():
	print("does this go off or nah")
	$MainMenu.queue_free()
	Lobby.visible = true
	$levelGroup.add_child(Lobby)
	##that might help
	get_node("levelGroup/Lobby").startTimer()
	
	
func _on_timer_timeout():
	$levelGroup/Lobby.queue_free()
	$levelGroup.add_child(level1)
