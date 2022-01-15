extends Area2D


signal hit(fish)


export var max_length: int = 400
export var speed: int = 500


var anchored_fish: Area2D = null


onready var squared_max_length = pow(max_length, 2)
onready var player = get_parent().find_node("Player")

onready var states = {
	"shoot": $StateMachine/Shoot
}

func _ready() -> void:
	connect("area_entered", self, "_on_fish_hit")
	
	
func point() -> void:
	rotation = player.global_position.angle_to_point(global_position) + PI / 2


func shoot() -> void:
	anchored_fish = null
	global_position = player.global_position
	var direction = (get_global_mouse_position() - player.global_position).normalized()	
	rotation = direction.angle() - PI / 2
	states.shoot.motion = direction * speed
	

func anchor(fish: Area2D) -> void:
	anchored_fish = fish
	

func squared_length() -> float:
	return global_position.distance_squared_to(player.global_position)


func is_max_length() -> bool:
	return squared_length() > squared_max_length
	

func _on_fish_hit(fish: Area2D) -> void:
	emit_signal("hit", fish)
