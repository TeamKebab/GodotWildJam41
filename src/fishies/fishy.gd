extends Area2D
class_name Fish


signal hooked
signal released
# warning-ignore:unused_signal
signal run_away


var hooked := false

export var type := "Default"


func flip() -> void:
	scale.x = - scale.x


func hook() -> void:
	hooked = true
	emit_signal("hooked")
	Game.fish_hooked(type)


func release() -> void:
	hooked = false
	emit_signal("released")
