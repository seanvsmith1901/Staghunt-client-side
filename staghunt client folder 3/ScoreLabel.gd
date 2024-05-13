extends Label


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str(Gamedata.score)
	self.size
	
	
func _increase_score(value):
	Gamedata.score += value
