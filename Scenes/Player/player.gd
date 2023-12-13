extends CharacterBody2D
class_name Player

var MAX_SPEED = 200
const SPRINT_SPEED = 400
const BASH_DURATION = 0.2
const JUMP_VELOCITY = -400.0
const LEAP_VELOCITY = -600.0
const ACCELERATION = 100

var direction = 0
var gravity = 980
var force = 300

@export var isDonkey = true
@export var isFinished = false

@onready var jump_particles = $JumpParticles
@onready var running_particles = $GPUParticles2D
@onready var sprite_donkey = $Sprite2DDonkey
@onready var sprite_toad = $Sprite2DToad
@onready var bash = $Bash as Bash
@onready var pivot = $Pivot

func _ready():
	sprite_toad.visible = false

func _physics_process(delta):
	if !isFinished:
		animations()
		flip_sprite()
		_gravity(delta)
		jumping()
		moving()
		bashing()
		mode()
		move_and_slide()
	

func _gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x, 0, 10)

func flip_sprite():
	var isRight = direction > 0
	var isLeft = direction < 0
	if isRight:
		pivot.position.x = 11
		running_particles.process_material.direction.x = -1
		sprite_toad.flip_h = false
		sprite_donkey.flip_h = false
	if isLeft:
		pivot.position.x = -11
		running_particles.process_material.direction.x = 1
		sprite_toad.flip_h = true
		sprite_donkey.flip_h = true
		
func bashing():
	if Input.is_action_just_pressed("bash") and isDonkey and bash.canBash and !bash.is_bashing():
		bash.start_bash(sprite_donkey, BASH_DURATION)
	if bash.is_bashing():
		velocity.x = direction * 500
	

func sprint_accelerate():
	velocity.x = move_toward(velocity.x, direction * SPRINT_SPEED, 20)


func moving():
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		if Input.is_action_pressed("sprint") and isDonkey:
			sprint_accelerate()
			running_particles.emitting = true
		else:
			accelerate()
			running_particles.emitting = false
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
		
func accelerate():
	velocity.x = move_toward(velocity.x, direction * MAX_SPEED, 20)
		
func animations():
	#Animations
	if isDonkey:
		if(velocity.x > 0 || velocity.x < 0):
			sprite_donkey.animation = "run"
		else:
			sprite_donkey.animation = "default"
	else:
		if(velocity.x > 0 || velocity.x < 0):
			sprite_toad.animation = "run"
		else:
			sprite_toad.animation = "default"
	

func jumping():
	if Input.is_action_just_pressed("jump") and is_on_floor() and isDonkey:
		velocity.y = JUMP_VELOCITY
		jump_particles.restart()
	elif Input.is_action_just_pressed("jump") and is_on_floor() and !isDonkey:
		velocity.y = LEAP_VELOCITY
		jump_particles.restart()


func mode():
	if Input.is_action_just_pressed("change_mode"):
		isDonkey = !isDonkey
		sprite_donkey.visible = isDonkey
		sprite_toad.visible = !isDonkey
		
		

func _on_tongue_hooked(hooked_position):
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", hooked_position, 0.4)
