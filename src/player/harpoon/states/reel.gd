extends "res://player/harpoon/states/base.gd"


var motion = Vector2.ZERO


func enter() -> void:
	harpoon.connect("hit", self, "_on_fish_hit")


func exit() -> void:
	harpoon.disconnect("hit", self, "_on_fish_hit")
	

func update(delta: float) -> void:
	if harpoon.squared_length() < 20:
		emit_signal("finished", "Hidden")
	else:
		harpoon.position += (harpoon.player.global_position - harpoon.global_position).normalized() * harpoon.speed * delta
		

func _on_fish_hit(fish: Fish) -> void:
	harpoon.anchor(fish)
	emit_signal("finished", "Anchor")
	

func reel_in() -> void:
	pass
