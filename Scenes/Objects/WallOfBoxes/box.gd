extends Node2D

@onready var area_2d = $Area2D
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles_2d = $GPUParticles2D
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	gpu_particles_2d.emitting = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and body.bash.is_bashing():
		var player_sfx = body.get_node("PlayerSFX")
		area_2d.visible = false
		animation_player.play("box_destroy")
		player_sfx.play_box_break()
		if is_instance_valid(collision_shape_2d):
			collision_shape_2d.queue_free()
