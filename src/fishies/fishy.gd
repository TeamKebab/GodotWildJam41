extends Area2D
class_name Fish


signal hooked
signal released


export var type := "Default"


onready var sprite: Sprite = $Sprite


func flip() -> void:
	sprite.flip_h = not sprite.flip_h


func hook() -> void:
	emit_signal("hooked")
	Game.fish_hooked(type)


func release() -> void:
	emit_signal("released")
