extends Node
class_name Bash

const DASH_DELAY = 0.4

@onready var ghost_timer = $GhostTimer
@onready var timer = $Timer as Timer
var canBash = true
var bash_ghost_scene = preload("res://Scenes/Abilities/bash_ghost.tscn")
var animated_sprite: AnimatedSprite2D
var player: Player 

func _ready():
	player = get_parent()

func start_bash(sprite, duration):
	self.animated_sprite = sprite
	timer.wait_time = duration
	timer.start()
	
	ghost_timer.start()
	instance_ghost()
	
func instance_ghost():
	var ghost: AnimatedSprite2D = bash_ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = self.global_position
	ghost.scale.x = 2
	ghost.scale.y = 2
	ghost.frame = animated_sprite.get_frame()
	ghost.animation = animated_sprite.animation
	ghost.flip_h = animated_sprite.flip_h
	
	
func is_bashing():
	return !timer.is_stopped()

func end_bash():
	ghost_timer.stop()
	canBash = false
	await get_tree().create_timer(DASH_DELAY).timeout
	canBash = true



func _on_timer_timeout():
	end_bash()


func _on_ghost_timer_timeout():
	instance_ghost()
