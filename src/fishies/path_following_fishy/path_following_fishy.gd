extends PathFollow2D


export var speed: int = 25
export var back: bool = false


onready var path: Path2D = get_parent()
onready var total_length:= path.curve.get_baked_length()


onready var fishy: Fish = $Fishy


func _ready() -> void:
	if back:
		fishy.flip()
		

func _physics_process(delta: float) -> void:
	var movement = speed * delta
	
	if back:
		if offset < movement:
			offset = movement - offset
			flip()
		else:
			offset -= movement
	else:
		if total_length - offset < movement:
			offset = 2 * total_length - offset - movement
			flip()
		else: 
			offset += movement
	

func flip() -> void:
	back = not back
	fishy.flip()
	
