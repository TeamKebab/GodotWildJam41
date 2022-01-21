extends Area2D


func _ready():
	connect("body_entered", self, "_on_player_entered")


func _on_player_entered(player: KinematicBody2D) -> void:
	Game.go_to(Game.Scene.Win)
