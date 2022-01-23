extends "res://player/harpoon/states/base.gd"


var motion = Vector2.ZERO

onready var reel_sound = $ReelSound

func enter() -> void:
	reel_sound.play()
	
	
func exit() -> void:
	reel_sound.call_deferred("stop")
	

func update(delta: float) -> void:
	if harpoon.squared_length() < 20:
		emit_signal("finished", "Hidden")
	else:
		harpoon.position += (harpoon.player.global_position - harpoon.global_position).normalized() * harpoon.speed * delta
		

func reel_in() -> void:
	pass
