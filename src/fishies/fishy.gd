extends Area2D
class_name Fish


signal hooked
signal released
signal run_away


var hooked := false

export var type := "Default"


onready var sprite: Sprite = $Sprite


func flip() -> void:
	sprite.flip_h = not sprite.flip_h


func hook() -> void:
	hooked = true
	emit_signal("hooked")
	Game.fish_hooked(type)


func release() -> void:
	hooked = false
	emit_signal("released")
