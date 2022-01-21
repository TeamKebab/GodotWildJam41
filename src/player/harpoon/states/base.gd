extends "res://components/state_machine/state.gd"


onready var harpoon = find_parent("Harpoon")


func handle_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reelin"):
		reel_in()
	elif Input.is_action_just_pressed("shoot"):
		shoot()


func shoot() -> void:
	pass


func reel_in() -> void:
	emit_signal("finished", "Reel")
