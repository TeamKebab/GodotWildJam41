extends "res://fishies/go_to_position_fishy/go_to_position_fishy.gd"


export var blow_up_delay: float = 0.2
export var float_speed: int = 70


onready var animation: AnimationPlayer = $AnimationPlayer
onready var start_position:= global_position
onready var base_speed:= speed


func _ready() -> void:
	connect("hooked", self, "_on_hooked")
	

func reset() -> void:
	hide()
	global_position = start_position
	speed = base_speed
	unit_offset = 0
	back = false
	sprite.flip_h = false
	rotation = 0
	animation.play("Idle")
	calculate_trajectory(end)
	
	yield(get_tree().create_timer(0.1), "timeout")
	show()
	
	
func blow_up() -> void:
	animation.play("Blown")
	rotation = - PI / 2
	
	speed = float_speed
	unit_offset = 0
	back = false
	sprite.flip_h = false
	calculate_trajectory(Vector2(global_position.x, 0))
	
	yield(self, "end_reached")
	emit_signal("run_away")
	reset()
	

func _on_hooked() -> void:
	yield(get_tree().create_timer(blow_up_delay), "timeout")
	blow_up()
