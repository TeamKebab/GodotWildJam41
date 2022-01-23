extends Node


var started = false


func _ready():
	yield(get_tree().create_timer(1), "timeout")
	started = true

func _input(event):
	if started:
		if event is InputEventKey or event is InputEventMouseButton:
			Game.start()
