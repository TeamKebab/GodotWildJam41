extends Node



func _on_Button_pressed():
	Game.go_to(Game.Scene.Tutorial)


func _on_OptionsButton_pressed():
	Game.go_to(Game.Scene.Options)
