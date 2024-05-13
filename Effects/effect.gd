extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("animation_finished", self.on_animation_finished) 
	frame = 0 #just reassurance but its technically not necessary. 
	play("Animate")
	
func on_animation_finished():
	queue_free()
