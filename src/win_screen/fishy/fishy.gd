extends KinematicBody2D

export var rotation_speed = 0.1
export var speed = 50

onready var motion = Vector2.ONE.rotated(PI * rand_range(-0.1, 0.1)) * speed

func _ready() -> void:
	position = Vector2(rand_range(80, 90), rand_range(80, 90))
	

func _physics_process(delta) -> void:
	rotation += rotation_speed * delta
	
	var collision = move_and_collide(motion * delta)
	
	if collision:
		motion = collision.normal.rotated(rand_range(-PI/10, PI/10)) * speed
