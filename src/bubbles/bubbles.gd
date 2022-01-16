extends Sprite


export var speed = 50
export var horizontal_movement = 50
export var frequency = 1 / PI

var is_going_up = false
var time = 0.0

onready var base_x = position.x
onready var animation = $AnimationPlayer

func up() -> void:
#	animation.play("up")
	is_going_up = true	
	
	
func _physics_process(delta: float) -> void:
	if is_going_up:
		time += delta
		position.x = base_x  + horizontal_movement * sin(time * frequency)
		position.y = position.y - speed * delta
