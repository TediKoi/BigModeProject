extends Control
class_name Hud

@onready var label = $PanelContainer/MarginContainer/Label
@onready var timer = 0.0
@onready var bash_cd_particle = $PanelContainer/MarginContainer/Bash/GPUParticles2D
@onready var bash_sprite = $PanelContainer/MarginContainer/Bash

var bash: Bash

func _ready():
	bash = get_parent().get_parent().get_node("Player").get_child(0)

func _process(delta):
	timer += delta
	label.text = format_time(timer)
	
	bash_cd_particle_effect()
	
func format_time(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))

func bash_cd_particle_effect():
	if bash.canBash:
		bash_sprite.modulate = Color(1, 1, 1, 1)
	else:
		bash_sprite.modulate = Color(1, 1, 1, 0)
		bash_cd_particle.restart()
		
	
