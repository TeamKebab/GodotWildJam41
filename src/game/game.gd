extends Node


enum Scene {
	Start,
	Level_01,
}


const main_score = preload("res://game/main_score.mp3")


onready var scene_loader = $SceneLoader


func _ready() -> void:
	randomize()
	
	scene_loader.scenes = {
		Scene.Start : "res://main.tscn",
		Scene.Level_01 : "res://main.tscn",
	}	
	
	play_music(main_score)


func restart() -> void:
	play_music(main_score)
	go_to(Scene.Start)


func play_music(stream: AudioStream) -> void:
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
	
	
func go_to(scene_id: int, startup_data = null) -> void:
	scene_loader.load_scene(scene_id, startup_data)
