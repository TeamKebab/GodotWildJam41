extends Area2D
class_name Fish


onready var sprite: Sprite = $Sprite


func flip() -> void:
	sprite.flip_h = not sprite.flip_h
