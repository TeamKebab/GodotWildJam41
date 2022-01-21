extends "res://fishies/go_to_position_fishy/go_to_position_fishy.gd"


export var throw_off_delay:= 1.5
export var down:= false

onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	connect("hooked", self, "_on_hooked")
	connect("released", self, "_on_released")
	update_animation()
	
	
func flip() -> void:
	.flip()
	update_animation()
	

func update_animation() -> void:
	if back != down:
		animation.play("Down")
	else:
		animation.play("Up")


func _on_hooked() -> void:
	# todo: show count down animation?
	yield(get_tree().create_timer(throw_off_delay), "timeout")
	
	if hooked:
		emit_signal("run_away")


func _on_released() -> void:
	# todo: reset animation
	pass
