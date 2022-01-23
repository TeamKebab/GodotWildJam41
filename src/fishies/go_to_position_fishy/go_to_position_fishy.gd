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
var end: Vector2


func _ready() -> void: 
	var end_node = find_node("End")
	end = end_node.global_position if end_node != null else global_position
		
	if back:
		scale.x = -1
		
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
	

func calculate_trajectory(new_end: Vector2) -> void:
	start = global_position
	length = start.distance_to(new_end)
	
	if length == 0:
		return
	
	total_time = length / speed
	direction = start.direction_to(new_end)
	perpendicular = direction.rotated(PI / 2)
	
	offset = unit_offset * total_time
	

func end_reached() -> void:
	back = not back
	flip()
	emit_signal("end_reached")
