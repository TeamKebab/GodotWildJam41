extends "res://fishies/go_to_position_fishy/go_to_position_fishy.gd"


export var throw_off_delay:= 1.5


func _ready() -> void:
	connect("hooked", self, "_on_hooked")
	connect("released", self, "_on_released")
	

func _on_hooked() -> void:
	# todo: show count down animation?
	yield(get_tree().create_timer(throw_off_delay), "timeout")
	# throw  player off if still attached


func _on_released() -> void:
	# todo: reset animation
	pass
