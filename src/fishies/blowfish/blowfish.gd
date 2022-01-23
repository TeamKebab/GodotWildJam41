extends "res://fishies/go_to_position_fishy/go_to_position_fishy.gd"


export var blow_up_delay: float = 0.2
export var float_speed: int = 70


onready var animation: AnimationPlayer = $AnimationPlayer
onready var start_position:= global_position
onready var base_speed:= speed
onready var visibility_notifier: VisibilityNotifier2D = $VisibilityNotifier2D

onready var blow_up_sound: AudioStreamPlayer2D = $BlowUpSound
onready var reappear_sound: AudioStreamPlayer2D = $ReappearSound


func _ready() -> void:
	connect("hooked", self, "_on_hooked")
	

func reset() -> void:
	hide()
	global_position = start_position
	speed = base_speed
	unit_offset = 0
	back = false
	scale.x = 1
	rotation = 0
	animation.play("Idle")
	calculate_trajectory(end)
	
	yield(get_tree().create_timer(0.1), "timeout")
	reappear_sound.play()
	show()
	
	
func blow_up() -> void:
	animation.play("Blown")
	blow_up_sound.play()
	rotation = - PI / 2
	
	speed = float_speed
	unit_offset = 0
	back = false
	scale.x = 1
	calculate_trajectory(Vector2(global_position.x, -2000))
	
	yield(visibility_notifier, "screen_exited")
	emit_signal("run_away")
	reset()
	

func _on_hooked() -> void:
	yield(get_tree().create_timer(blow_up_delay, false), "timeout")
	blow_up()
