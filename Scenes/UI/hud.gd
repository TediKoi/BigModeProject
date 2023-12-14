extends Control
class_name Hud

@onready var label = $PanelContainer/MarginContainer/Label
@onready var timer = 0.0
@onready var bash_cd_particle = $BashControl/Bash/GPUParticles2D
@onready var bash_sprite = $BashControl/Bash
@onready var mode_change = $ModeControl/ModeChange
@onready var mode_change_particle = $ModeControl/ModeChange/GPUParticles2D
@onready var tongue_sprite = $Control/Tongue
@onready var tongue_particle = $Control/Tongue/GPUParticles2D

var donkey_sprite = preload("res://Scenes/Player/donkey_idle.png")
var toad_sprite = preload("res://Scenes/Player/donkeytoad_idle.png")

var bash: Bash
var player: Player
var tongue: Tongue

func _ready():
	player = get_parent().get_parent().get_node("Player")
	bash = get_parent().get_parent().get_node("Player").get_child(0)
	tongue = get_parent().get_parent().get_node("Player/Pivot/Tongue")

func _process(delta):
	timer += delta
	label.text = format_time(timer)
	
	bash_cd_particle_effect()
	on_mode_change()
	on_tongue()
	
func format_time(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))

func bash_cd_particle_effect():
	if bash.canBash and player.isDonkey:
		bash_sprite.modulate = Color(1, 1, 1, 1)
	else:
		bash_sprite.modulate = Color(1, 1, 1, 0)
		bash_cd_particle.restart()
		
func on_tongue():
	if tongue.canHook:
		tongue_sprite.modulate = Color(1, 1, 1, 1)
	elif !tongue.canHook:
		tongue_sprite.modulate = Color(1, 1, 1, 0)
		tongue_particle.restart()
		
func on_mode_change():
	if player.canChange:
		mode_change.modulate = Color(1, 1, 1, 1)
	else:
		mode_change.modulate = Color(1, 1, 1, 0)
		mode_change_particle.restart()
		if player.isDonkey:
			mode_change.texture = toad_sprite
		else:
			mode_change.texture = donkey_sprite
		
	
