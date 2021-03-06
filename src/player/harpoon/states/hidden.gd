extends "res://player/harpoon/states/base.gd"


func enter():
	harpoon.hide()


func exit():
	harpoon.show()


func update(_delta: float) -> void:
	harpoon.position = harpoon.player.position


func shoot() -> void:
	harpoon.shoot()
	emit_signal("finished", "Shoot")
