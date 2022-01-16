extends PathFollow2D


export var speed: int = 100


func _physics_process(delta: float) -> void:
	offset += speed * delta
	
