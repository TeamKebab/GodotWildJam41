extends KinematicBody2D


onready var motion = $Motion


func _physics_process(delta: float) -> void:
	motion.move(delta)
