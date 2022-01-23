extends Node


onready var music_volume = $MarginContainer/Options/MusicVolume/HSlider
onready var sounds_volume = $MarginContainer/Options/SoundsVolume/HSlider
onready var show_tips = $MarginContainer/Options/ShowTips/CheckBox

onready var changed_sound = $ChangedSound

onready var music_bus = AudioServer.get_bus_index("Music")
onready var sounds_bus = AudioServer.get_bus_index("Sounds")


func _ready() -> void:
	music_volume.value = db_to_value(AudioServer.get_bus_volume_db(music_bus))
	sounds_volume.value = db_to_value(AudioServer.get_bus_volume_db(sounds_bus))
	show_tips.pressed = Game.show_puns
	

func _on_BackButton_pressed():
	Game.go_to(Game.Scene.Start)


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value_to_db(value))
	changed_sound.play()

func _on_sound_value_changed(value):
	AudioServer.set_bus_volume_db(sounds_bus, value_to_db(value))
	changed_sound.play()


var max_volume = 6
var min_volume = -24

func value_to_db(value):
	if value < 0:
		return -80
	else:
		return (max_volume - min_volume) / 10.0 * value + min_volume


func db_to_value(db):
	if db < min_volume:
		return -1
	else:
		return  (db - min_volume) * 10.0 / (max_volume - min_volume)


func _on_CheckBox_toggled(button_pressed):
	Game.show_puns = button_pressed
