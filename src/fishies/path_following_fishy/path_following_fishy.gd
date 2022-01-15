extends PathFollow2D


onready var fish = $Fishy

func _physics_process(delta: float) -> void:
	offset += fish.speed * delta
	
