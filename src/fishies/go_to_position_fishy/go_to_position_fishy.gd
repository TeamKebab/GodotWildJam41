extends Fish


export var speed:= 25
export var amplitude:= 2
export var frequency:= 5
export(float, 0, 1, 0.05) var unit_offset:= 0.0
export var back:= false


var offset:= 0.0 

onready var start: Vector2 = global_position
onready var end: Vector2 =  $End.global_position if $End != null else global_position
onready var length: float = start.distance_to(end)
onready var total_time: float = length / speed

onready var direction: Vector2 = start.direction_to(end)
onready var perpendicular: Vector2 = direction.rotated(PI / 2)


func _ready() -> void: 
	if back:
		.flip()
		
	if length > 0:
		offset = unit_offset * total_time
	

func _physics_process(delta: float) -> void:
	if length == 0:
		return
	
	if back:
		if delta > offset:
			flip()
			offset = delta - offset
		else:
			offset -= delta
	else:
		if delta > total_time - offset:
			flip()
			offset = 2 * total_time - offset - delta
		else:
			offset += delta
	
	var x = speed * offset
	var y = amplitude * cos(frequency * offset)	
	
	if back:
		if x <= 0:
			flip()
	else:
		if x >= length:
			flip()
			
	global_position = start + x * direction + y * perpendicular
	

func flip() -> void:
	back = not back
	.flip()
