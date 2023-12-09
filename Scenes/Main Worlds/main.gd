extends Node

@onready var camera_2d = $Camera2D
@onready var victory_screen = $CanvasLayer/VictoryScreen


var player: Array
var current_player: Node2D

func _ready():
	victory_screen.unpause()

func _process(_delta):
	player = get_tree().get_nodes_in_group("player")
	if player[0] == null:
		current_player = player[1]
	else:
		current_player = player[0]
	
	camera_2d.global_position = current_player.global_position
	
