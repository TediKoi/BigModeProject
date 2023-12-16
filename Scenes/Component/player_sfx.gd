extends Node2D
class_name PlayerSfx

var player: Player
var time_limit = false
var bash: Bash

@onready var horse_footstep = $HorseFootstep
@onready var horse_sprinting = $HorseSprinting
@onready var timer = $Timer
@onready var bash_sfx = $Bash
@onready var jump = $Jump
@onready var tongue = $Tongue
@onready var box_break = $BoxBreak
@onready var toad_croak = $ToadCroak
@onready var donkey_sound = $DonkeySound



func _ready():
	player = get_parent()
	bash = player.get_node("Bash")
	
func play_walking():
	if player.isWalking and player.is_on_floor():
		if !time_limit:
			time_limit = true
			timer.start()
			horse_footstep.play()
	
	
func play_sprinting():
	if player.isSprinting and player.is_on_floor():
		if !time_limit:
			time_limit = true
			timer.start()
			horse_sprinting.play()
			
func play_bash():
	bash_sfx.play()
	
func play_jump():
	jump.play()
	
func play_tongue():
	tongue.play()
	
func play_box_break():
	box_break.play()
	
func play_toadcroak():
	toad_croak.play()
	
func play_donkeysound():
	donkey_sound.play()


func _on_timer_timeout():
	time_limit = false


