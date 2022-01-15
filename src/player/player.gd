extends KinematicBody2D


export var float_acceleration: int = 150
export var friction_acceleration: int = 100
export var reel_in_acceleration: int = 500

export var max_speed: int = 5000
export var max_float_speed: int = 200

export var disco_mode: bool = false

var motion = Vector2.ZERO

onready var harpoon = get_parent().find_node("Harpoon")


func _physics_process(delta: float) -> void:	
	var fish_direction = (harpoon.global_position - global_position).normalized()
			
	if harpoon.is_anchored():
		if is_reeling_in():
			motion = motion.move_toward(max_speed * fish_direction, reel_in_acceleration * delta)	
		else:
			float_up(delta)	
			motion = motion.move_toward(Vector2.ZERO, friction_acceleration * delta)
	else:
		float_up(delta)	
		motion = motion.move_toward(Vector2.ZERO, friction_acceleration * delta)
		
	if harpoon.is_anchored() and harpoon.is_max_length():
		var projected = motion.project(fish_direction)
		if projected.y < 0:
			motion = projected.x * fish_direction.rotated(PI/2)	
		
	motion = move_and_slide(motion, Vector2.DOWN)
	

	if harpoon.is_anchored() and harpoon.is_max_length():
		global_position = harpoon.global_position - harpoon.max_length * fish_direction

	update()


func _draw():
	if disco_mode:
		if harpoon.is_anchored():
			draw_line(Vector2.ZERO, harpoon.global_position - global_position, Color.aqua, 4)
			
		draw_line(Vector2.ZERO, motion, Color.red, 2)
			
		if harpoon.is_anchored() :
			var fish_direction = (harpoon.global_position - global_position).normalized()
			var projected = motion.project(fish_direction)
			
			draw_line(Vector2.ZERO, projected.x * fish_direction.rotated(PI/2), Color.green, 2)
			draw_line(Vector2.ZERO, projected.y * fish_direction, Color.purple, 2)
	

func float_up(delta: float) -> void:
	motion.y = max(-max_float_speed, motion.y - float_acceleration * delta)
	

func is_reeling_in() -> bool:
	return Input.is_mouse_button_pressed(BUTTON_RIGHT)
