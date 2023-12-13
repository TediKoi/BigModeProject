extends AnimatedSprite2D

var tween: Tween

func _ready():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.finished.connect(_on_ghost_finished)
	
func _on_ghost_finished():
	queue_free()
