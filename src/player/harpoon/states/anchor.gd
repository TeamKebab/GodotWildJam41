extends "res://player/harpoon/states/base.gd"


func exit() -> void:
	harpoon.anchored_fish = null
	

func update(delta: float) -> void:
	harpoon.global_position = harpoon.anchored_fish.global_position
	harpoon.point()
	

func shoot() -> void:
	emit_signal("finished", "Reel")
	

func reel_in() -> void:
	pass
