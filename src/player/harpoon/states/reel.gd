extends "res://player/harpoon/states/base.gd"


var motion = Vector2.ZERO
var is_current = false

onready var reel_sound = $ReelSound

func enter() -> void:
	reel_sound.play()
	is_current = true
	
func exit() -> void:
	is_current = false
	yield(get_tree().create_timer(0.1), "timeout")
	
	if not is_current:
		reel_sound.stop()
	

func update(delta: float) -> void:
	if harpoon.squared_length() < 20:
		emit_signal("finished", "Hidden")
	else:
		harpoon.position += (harpoon.player.global_position - harpoon.global_position).normalized() * harpoon.speed * delta
		

func reel_in() -> void:
	pass
