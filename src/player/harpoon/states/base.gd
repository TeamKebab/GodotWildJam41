extends "res://components/state_machine/state.gd"


onready var harpoon = find_parent("Harpoon")


func handle_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			shoot()
		elif event.button_index == BUTTON_RIGHT:
			reel_in()


func shoot() -> void:
	harpoon.shoot()
	emit_signal("finished", "Shoot")


func reel_in() -> void:
	emit_signal("finished", "Hidden")
