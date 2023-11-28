extends CharacterBody2D

const MAX_SPEED = 200
const JUMP_VELOCITY = -400.0
const ACCELERATION = 100

var direction = Vector2.ZERO

@onready var sprite = $Sprite2D

var gravity = 980

func _physics_process(delta):
	animations()
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x, 0, 10)
	jumping()
	moving()
	move_and_slide()
	flip_sprite()
	
	
func animations():
	#Animations
	if(velocity.x > 0 || velocity.x < 0):
		sprite.animation = "run"
	else:
		sprite.animation = "default"
		
func moving():
	direction = Input.get_axis("move_left", "move_right")
	if direction: 
		if Input.is_action_pressed("sprint"):
			sprint_accelerate()
		else:
			accelerate()
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
		
func accelerate():
	var isRight = direction > 0
	var isLeft = direction < 0
	if isRight:
		velocity.x = move_toward(velocity.x, MAX_SPEED, 20)
	if isLeft:
		velocity.x = move_toward(velocity.x, -MAX_SPEED, 20)
		
func sprint_accelerate():
	var isRight = direction > 0
	var isLeft = direction < 0
	if isRight:
		velocity.x = move_toward(velocity.x, MAX_SPEED + 200, 20)
	if isLeft:
		velocity.x = move_toward(velocity.x, -MAX_SPEED - 200, 20)
	

func jumping():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func flip_sprite():
	var isRight = direction > 0
	var isLeft = direction < 0
	if isRight:
		sprite.flip_h = false
	if isLeft:
		sprite.flip_h = true
