extends "res://player/harpoon/states/base.gd"


var motion = Vector2.ZERO


func enter() -> void:
	harpoon.connect("hit", self, "_on_fish_hit")


func exit() -> void:
	harpoon.disconnect("hit", self, "_on_fish_hit")
	

func _on_fish_hit(fish: Area2D) -> void:
	harpoon.anchor(fish)
	emit_signal("finished", "Anchor")
	


