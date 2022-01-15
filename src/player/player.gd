extends KinematicBody2D


export var pull: int = 100
export var friction: int = 10

export var reel_in_speed: int = 500
export var max_speed: int = 5000
export var max_float_speed: int = 200

var motion = Vector2.ZERO


onready var harpoon = get_parent().find_node("Harpoon")


func _physics_process(delta: float) -> void:
	if is_reeling_in():
		var fish_direction = (harpoon.global_position - global_position).normalized()
		motion = motion.move_toward(max_speed * fish_direction, reel_in_speed * delta)
	else:
		motion = motion.move_toward(Vector2(0, -max_float_speed), pull * delta)
	
	motion = move_and_slide(motion, Vector2.DOWN)

		

func is_reeling_in() -> bool:
	return harpoon.anchored_fish != null and Input.is_mouse_button_pressed(BUTTON_RIGHT)
