extends Area2D
class_name Harpoon

signal hit(fish)


export var max_length: int = 300
export var speed: int = 500


var anchored_fish: Area2D = null


onready var squared_max_length = pow(max_length, 2)
onready var player = get_parent().find_node("Player")
onready var chain = $Chain
onready var chain_start = $ChainStart

onready var states = {
	"shoot": $StateMachine/Shoot
}

func _ready() -> void:
	connect("area_entered", self, "_on_fish_hit")
	
	
func _physics_process(_delta: float) -> void:
	chain.rotation = -rotation
	chain.start = chain_start.position.rotated(rotation)
	chain.end = player.global_position - global_position
	
	
func point() -> void:
	rotation = player.global_position.angle_to_point(global_position) + PI / 2


func shoot() -> void:
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
	

func is_anchored() -> bool:
	return anchored_fish != null
	

func enable() -> void:
	$StateMachine._change_state("Hidden")
	

func disable() -> void:
	$StateMachine._change_state("Disabled")
	
	
func _on_fish_hit(fish: Area2D) -> void:
	emit_signal("hit", fish)
