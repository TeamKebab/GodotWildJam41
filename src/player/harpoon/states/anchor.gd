extends "res://player/harpoon/states/base.gd"


onready var latch_sound = $LatchSound


func enter() -> void:
	latch_sound.play()
	yield(latch_sound, "finished")
	harpoon.anchored_fish.hook()
	
	
func exit() -> void:
	harpoon.anchored_fish = null
	

func update(delta: float) -> void:
	harpoon.global_position = harpoon.anchored_fish.global_position
	harpoon.point()
	

func shoot() -> void:
	emit_signal("finished", "Reel")
	

func reel_in() -> void:
	pass
