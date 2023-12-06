extends Node2D

@onready var area_2d = $Area2D
@onready var finish_flag = $"."


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		#play victory screen
		body.isFinished = true
