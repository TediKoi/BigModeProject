extends Sprite2D
class_name Tongue

@onready var ray_cast_2d = $RayCast2D
var distance: float = 300.0
var player: Player
var canHook = true
var player_sfx: PlayerSfx
var isHooked = false

signal hooked(hooked_position)

func _ready():
	player = get_parent().get_parent()
	player_sfx = player.get_node("PlayerSFX")

func _process(_delta):
	hook()


func interpolate(length, duration = 0.2):
	var tween_offset = get_tree().create_tween()
	var tween_rect_h = get_tree().create_tween()
	
	tween_offset.tween_property(self, "offset", Vector2(0, length/2.0), duration)
	tween_rect_h.tween_property(self, "region_rect", Rect2(0, 0, 32, length), duration)
	

func hook():
	if Input.is_action_pressed("hook") and !player.isDonkey and canHook:
		player_sfx.play_tongue()
		interpolate(await check_collision(), 0.2)
		await get_tree().create_timer(0.2).timeout
		reverse_interpolation()
		
func reverse_interpolation():
	interpolate(0, 0.4)
	start_cooldown()
	
func start_cooldown():
	canHook = false
	await get_tree().create_timer(2.0).timeout
	isHooked = false
	canHook = true

func check_collision():
	await get_tree().create_timer(0.1).timeout
	var collision_point
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point()
		distance = (global_position - collision_point).length()
		hooked.emit(collision_point)
		isHooked = true
	else:
		distance = 300.0
	return distance
