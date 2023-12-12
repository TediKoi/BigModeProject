extends Node2D

func _process(_delta):
	hook_mouse()
	
func hook_mouse():
	if Input.is_action_just_pressed("hook"):
		look_at(get_global_mouse_position())
