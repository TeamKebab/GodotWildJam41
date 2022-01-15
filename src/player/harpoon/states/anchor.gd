extends "res://player/harpoon/states/base.gd"


func update(delta: float) -> void:
	harpoon.global_position = harpoon.anchored_fish.global_position
	harpoon.point()
	

func reel_in() -> void:
	pass
