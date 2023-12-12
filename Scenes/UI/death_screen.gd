extends ColorRect
class_name DeathScreen

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var retry_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Retry
@onready var quit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Quit

func death_unpause():
	animator.play("Unpause")
	get_tree().paused = false
	visible = false
	
func death_pause():
	animator.play("Pause")
	get_tree().paused = true
	visible = true


func _on_retry_pressed():
	var main = get_tree().get_root().get_node("Main")
	if main.world_num == 1:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main.tscn")
	elif main.world_num == 2:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main2.tscn")
	elif main.world_num == 3:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main3.tscn")
	death_unpause()


func _on_quit_pressed():
	get_tree().quit()
	

