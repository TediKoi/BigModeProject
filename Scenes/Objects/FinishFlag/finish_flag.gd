extends Node2D

@onready var area_2d = $Area2D
@onready var finish_flag = $"."


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var victory_screen = get_tree().get_first_node_in_group("canvas_layer").get_node("VictoryScreen") as VictoryScreen
		victory_screen.pause()
