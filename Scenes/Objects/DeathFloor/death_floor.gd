extends Node2D

var death_screen: DeathScreen

func _ready():
	death_screen = get_tree().get_first_node_in_group("canvas_layer").get_node("DeathScreen")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.visible = false
		death_screen.death_pause()
