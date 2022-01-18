extends Area2D
class_name Fish


export var type := "Default"


onready var sprite: Sprite = $Sprite


func flip() -> void:
	sprite.flip_h = not sprite.flip_h


func hook() -> void:
	Game.fish_hooked(type)


func _on_turn() -> void:
	flip()
