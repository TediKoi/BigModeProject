extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("hook"):
		look_at(get_global_mouse_position())
