extends Control


var started = false


onready var time: Label = $MarginContainer/VBoxContainer/TotalTime/Value
onready var urchins: Label = $MarginContainer/VBoxContainer/TimesUrchined/Value
onready var fishies: Label = $MarginContainer/VBoxContainer/FishHooked/Value


func _ready():
	Game.stop_timer()
	
	var minutes = Game.total_mseconds / 60000
	var seconds = (Game.total_mseconds / 1000) % 60
	
	time.text = "%01d:%02d" % [minutes, seconds]
	
	var fish = Game.stats["fish"] if "fish" in Game.stats else 0
	fishies.text = str(fish)
	
	var urchined = Game.stats["urchin"] if "urchin" in Game.stats else 0
	urchins.text = str(urchined)
	
	yield(get_tree().create_timer(1), "timeout")
	started = true

func _input(event):
	if started:
		if event is InputEventKey or event is InputEventMouseButton:
			Game.restart()
