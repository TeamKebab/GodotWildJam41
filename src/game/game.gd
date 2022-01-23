extends Node


enum Scene {
	Start,
	Tutorial,
	Win,
	Level_01,
}


const main_score = preload("res://game/main_score.mp3")

export var show_puns := true

var total_mseconds:= 0
var stats:= {}
var hooked_fishes := []
var popups:= {}
var start_time

onready var scene_loader = $SceneLoader
onready var popup_container = $CanvasLayer

func _ready() -> void:
	randomize()
	
	scene_loader.scenes = {
		Scene.Start : "res://main.tscn",
		Scene.Tutorial: "res://tutorial_screen/tutorial_screen.tscn",
		Scene.Win: "res://win_screen/win_screen.tscn",
		Scene.Level_01 : "res://main.tscn",
	}	
	
	for popup in popup_container.get_children():
		popups[popup.name] = popup
	
	
	play_music(main_score)
	
	start_time = OS.get_ticks_msec()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_R:
		get_tree().reload_current_scene()


func stat(type: String) -> void:
	if type in stats:
		stats[type] += 1
	else:
		stats[type] = 1
	

func restart() -> void:
	play_music(main_score)
	go_to(Scene.Start)
	hooked_fishes = []
	stats = {}
	total_mseconds = 0


func play_music(stream: AudioStream) -> void:
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
	
	
func go_to(scene_id: int, startup_data = null) -> void:
	scene_loader.load_scene(scene_id, startup_data)


func fish_hooked(type: String) -> void:
	stat("fish")
	
	if show_puns and not hooked_fishes.has(type):
		hooked_fishes.append(type)
		pause()
		if popups.has(type):
			popups[type].popup_centered_minsize()
		else:
			popups["Default"].popup_centered_minsize()


func pause() -> void:
	get_tree().paused = true
	stop_timer()
	

func continue() -> void:
	start_time = OS.get_ticks_msec()
	get_tree().paused = false


func stop_timer() -> void:
	total_mseconds += OS.get_ticks_msec() - start_time
