extends Line2D

export var start: Vector2
export var end: Vector2


export var max_amplitude:= 5.0
export var period:= 100.0
export var step = 0.02
export var change_speed:= 20

export var debugging = false

var change:= 1
var amplitude:= max_amplitude



func create() -> void:
	var some_points = [start]
	
	var direction = (end-start).normalized()
	var perpendicular = direction.rotated(PI/2)
	var total_length = (end-start).length()
	
	var angle = step * 2 * PI
	var offset = step * period
	
	while offset < total_length:
		var deviation = amplitude * sin(angle)
		var a_point = start + offset * direction + deviation * perpendicular
		some_points.append(a_point)
		
		offset += step * period
		angle += step * 2 * PI
		
		
	points = PoolVector2Array(some_points)
	

func _ready():
	if debugging:
		start = Vector2(100,100)
		end = Vector2(200, 356)


func _physics_process(delta: float) -> void:
	var this_change = change_speed * delta
	amplitude += change * this_change
	
	if abs(amplitude) > max_amplitude:
		var extra = abs(amplitude) - max_amplitude
		change = change * -1
		amplitude += change * extra
	
	create()


func _draw():
	if debugging:
		var some_points = Array(points)
		draw_line(start, end, Color.red, 3)
	
