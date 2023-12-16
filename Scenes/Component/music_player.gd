extends Node2D

@onready var music = $AudioStreamPlayer2D

var player: Player

func _ready():
	music.play()
	player = get_tree().get_first_node_in_group("player")
	
func _process(_delta):
	global_position = player.global_position
