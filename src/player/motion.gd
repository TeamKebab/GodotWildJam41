extends Node


export var pull: int = 200
export var max_speed: int = 50


var motion = Vector2.ZERO


onready var body: KinematicBody2D = get_parent()


func move(delta: float) -> void:
	motion.y = min(max_speed, motion.y - pull * delta)
		
	motion = body.move_and_slide(motion, Vector2.DOWN)
	
