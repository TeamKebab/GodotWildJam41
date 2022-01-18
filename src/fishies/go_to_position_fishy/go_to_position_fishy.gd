extends Fish


signal end_reached


export var speed:= 25
export var amplitude:= 2
export var frequency:= 5
export(float, 0, 1, 0.05) var unit_offset:= 0.0
export var back:= false


var offset:= 0.0 
var start: Vector2
var length: float
var total_time: float

var direction: Vector2
var perpendicular: Vector2

onready var end: Vector2 =  $End.global_position if $End != null else global_position


func _ready() -> void: 
	if back:
		flip()
		
	calculate_trajectory(end)
	

func _physics_process(delta: float) -> void:
	if length == 0:
		return
	
	if back:
		if delta > offset:
			end_reached()
			offset = delta - offset
		else:
			offset -= delta
	else:
		if delta > total_time - offset:
			end_reached()
			offset = 2 * total_time - offset - delta
		else:
			offset += delta
	
	var x = speed * offset
	var y = amplitude * cos(frequency * offset)	
				
	global_position = start + x * direction + y * perpendicular
	

func calculate_trajectory(end: Vector2) -> void:
	start = global_position
	length = start.distance_to(end)
	
	if length == 0:
		return
	
	total_time = length / speed
	direction = start.direction_to(end)
	perpendicular = direction.rotated(PI / 2)
	
	offset = unit_offset * total_time
	

func end_reached() -> void:
	back = not back
	flip()
	emit_signal("end_reached")
