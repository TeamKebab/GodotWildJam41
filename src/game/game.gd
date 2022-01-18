extends Node


enum Scene {
	Start,
	Level_01,
}


const main_score = preload("res://game/main_score.mp3")


export var show_puns := true

var hooked_fishes := []


onready var scene_loader = $SceneLoader
onready var popup: Popup = $CanvasLayer/Popup

func _ready() -> void:
	randomize()
	
	scene_loader.scenes = {
		Scene.Start : "res://main.tscn",
		Scene.Level_01 : "res://main.tscn",
	}	
	
	play_music(main_score)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_R:
		get_tree().reload_current_scene()


func restart() -> void:
	play_music(main_score)
	go_to(Scene.Start)
	hooked_fishes = []


func play_music(stream: AudioStream) -> void:
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
	
	
func go_to(scene_id: int, startup_data = null) -> void:
	scene_loader.load_scene(scene_id, startup_data)


func fish_hooked(type: String) -> void:
	if show_puns and not hooked_fishes.has(type):
		hooked_fishes.append(type)
		get_tree().paused = true
		popup.popup_centered_minsize()


func continue() -> void:
	get_tree().paused = false
