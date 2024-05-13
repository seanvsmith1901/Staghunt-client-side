extends Node2D


@onready var timer = get_node("Timer")
@export var ROUND_TIME = 5
signal deleteLobby

func startTimer():
	timer.start(ROUND_TIME)

func _on_timer_timeout():
	deleteLobby.emit()
