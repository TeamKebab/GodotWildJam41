extends "res://fishies/go_to_position_fishy/go_to_position_fishy.gd"


export var light_up_delay: float = 0.2


onready var animation: AnimationPlayer = $AnimationPlayer
onready var big_light: Light2D = $Angler/BigLight


func _ready() -> void:
	connect("hooked", self, "_on_hooked")
	connect("released", self, "_on_released")
	
	
func light_on() -> void:
	animation.play("Caught")
	big_light.show()
	

func light_off() -> void:
	animation.play("Idle")
	big_light.hide()
	
	
func _on_hooked() -> void:
	yield(get_tree().create_timer(light_up_delay), "timeout")
	light_on()


func _on_released() -> void:
	light_off()
