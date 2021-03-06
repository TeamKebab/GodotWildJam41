extends KinematicBody2D


export var float_acceleration: int = 100
export var friction_acceleration: int = 50
export var reel_in_acceleration: int = 400

export var max_speed: int = 500
export var max_float_speed: int = 200

export var disco_mode: bool = false

var motion = Vector2.ZERO
var was_on_floor: bool

onready var harpoon: Harpoon = get_parent().find_node("Harpoon")
onready var crash_sound = $CrashSound
onready var hit_sound = $HitSound

onready var hitbox = $Hitbox
onready var disable_tween = $DisableTween
 

func _ready() -> void:
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	

func _physics_process(delta: float) -> void:	
	var fish_direction = (harpoon.global_position - global_position).normalized()
			
	if harpoon.is_anchored():
		if is_reeling_in():
			motion = motion.move_toward(max_speed * fish_direction, reel_in_acceleration * delta)	
		else:
			float_up(delta)	
			motion = motion.move_toward(Vector2.ZERO, friction_acceleration * delta)
	else:
		float_up(delta)	
		motion = motion.move_toward(Vector2.ZERO, friction_acceleration * delta)
		
		
	if harpoon.is_anchored() and harpoon.is_max_length():
		if fish_direction.dot(motion) < 0:
			# facing opposite directions
			motion = motion.project(fish_direction.rotated(PI/2))
		
		motion +=  10 * fish_direction
	
	motion = move_and_slide(motion, Vector2.DOWN)
	
	var is_on_floor = is_on_ceiling() or is_on_floor() or is_on_wall()
	
	if not was_on_floor and is_on_floor and not crash_sound.playing:
		crash_sound.play()
	
	was_on_floor = is_on_floor
	
	update()


func _draw():
	if disco_mode:
		draw_line(Vector2.ZERO, harpoon.global_position - global_position, Color.aqua, 4)
		draw_line(Vector2.ZERO, (harpoon.global_position - global_position).normalized() * harpoon.max_length, Color.violet, 2)
			
		draw_line(Vector2.ZERO, motion, Color.red, 2)
			


func float_up(delta: float) -> void:
	motion.y = max(-max_float_speed, motion.y - float_acceleration * delta)
	

func is_reeling_in() -> bool:
	return Input.is_action_pressed("reelin")


func urchin_hit(urchin: Urchin) -> void:
	hit_sound.play()
	Game.stat("urchin")
	harpoon.disable()
	motion = urchin.global_position.direction_to(global_position) * urchin.bounce_speed
	
	var duration = 0.2
	var delay = 0
	
	for i in 3:
		disable_tween.interpolate_property($Sprite, "modulate", 
			Color.white, Color.transparent, 
			duration, 
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 
			delay)
		delay += duration
		
		disable_tween.interpolate_property($Sprite, "modulate", 
			Color.transparent, Color.white, 
			duration, 
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 
			delay)
		delay += duration
	
	disable_tween.start()
	
	yield(disable_tween, "tween_all_completed")
	
	harpoon.enable()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Urchin:
		urchin_hit(area)
		
