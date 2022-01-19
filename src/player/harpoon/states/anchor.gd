extends "res://player/harpoon/states/base.gd"


var enter_finished = false

onready var latch_sound = $LatchSound


func enter() -> void:
	latch_sound.play()
	yield(latch_sound, "finished")
	if harpoon.anchored_fish == null:
		return
		
	harpoon.anchored_fish.hook()
	harpoon.anchored_fish.connect("run_away", self, "_on_fish_ran_away")
	enter_finished = true
	
	
func exit() -> void:
	enter_finished = false
	harpoon.anchored_fish.disconnect("run_away", self, "_on_fish_ran_away")
	harpoon.anchored_fish.release()
	harpoon.anchored_fish = null
	

func update(delta: float) -> void:
	harpoon.global_position = harpoon.anchored_fish.global_position
	harpoon.point()
	

func shoot() -> void:
	if enter_finished:
		emit_signal("finished", "Reel")
	

func reel_in() -> void:
	pass


func _on_fish_ran_away() -> void:
	emit_signal("finished", "Reel")
