extends Control

@onready var menu_music = $AudioStreamPlayer2D


func _ready():
	menu_music.play()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Worlds/main.tscn")


func _on_quit_pressed():
	get_tree().quit()
