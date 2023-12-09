extends ColorRect
class_name VictoryScreen

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var retry_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Retry
@onready var next_level_button = $"CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Next Level"
@onready var quit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Quit

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	
func pause():
	animator.play("Pause")
	get_tree().paused = true


func _on_retry_pressed():
	unpause()


func _on_quit_pressed():
	get_tree().quit()


func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Worlds/level2.tscn")
	

