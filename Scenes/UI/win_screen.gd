extends ColorRect
class_name WinScreen

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var retry_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Retry
@onready var quit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Quit
@onready var label_2 = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label2

var timer: TimerNode

func _ready():
	timer = get_tree().get_first_node_in_group("canvas_layer").get_node("Timer") as TimerNode

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	visible = false
	
func pause():
	animator.play("Pause")
	get_tree().paused = true
	visible = true
	label_2.text = timer.label.text


func _on_retry_pressed():
	var main = get_tree().get_root().get_node("Main")
	if main.world_num == 1:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main.tscn")
	elif main.world_num == 2:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main2.tscn")
	elif main.world_num == 3:
		get_tree().change_scene_to_file("res://Scenes/Main Worlds/main3.tscn")
	unpause()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/menu.tscn")
