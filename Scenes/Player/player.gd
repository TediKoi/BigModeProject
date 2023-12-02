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

@export var isDonkey = true

@onready var sprite_donkey = $Sprite2DDonkey
@onready var sprite_toad = $Sprite2DToad
@onready var bash = $Bash

func _ready():
	sprite_toad.visible = false

func _physics_process(delta):
	animations()
	flip_sprite()
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x, 0, 10)
	jumping()
	moving()
	bashing()
	mode()
	move_and_slide()
	
func flip_sprite():
	var isRight = direction > 0
	var isLeft = direction < 0
	if isRight:
		sprite_toad.flip_h = false
		sprite_donkey.flip_h = false
	if isLeft:
		sprite_toad.flip_h = true
		sprite_donkey.flip_h = true
		
func bashing():
	if Input.is_action_just_pressed("bash") and isDonkey:
		bash.start_bash(BASH_DURATION)
	if bash.is_bashing():
		velocity.x = direction * 500
	

func sprint_accelerate():
	velocity.x = move_toward(velocity.x, direction * SPRINT_SPEED, 20)
		
func moving():
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		if Input.is_action_pressed("sprint") and isDonkey:
			sprint_accelerate()
		else:
			accelerate()
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
	elif Input.is_action_just_pressed("jump") and is_on_floor() and !isDonkey:
		velocity.y = LEAP_VELOCITY


func mode():
	if Input.is_action_just_pressed("change_mode"):
		isDonkey = !isDonkey
		sprite_donkey.visible = isDonkey
		sprite_toad.visible = !isDonkey
