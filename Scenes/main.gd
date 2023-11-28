extends Node

@onready var camera_2d = $Camera2D
@onready var player = $Player

func _process(_delta):
	camera_2d.global_position = player.global_position
