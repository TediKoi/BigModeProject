extends Control

@onready var label = $PanelContainer/MarginContainer/Label
@onready var timer = 0.0

func _process(delta):
	timer += delta
	label.text = format_time(timer)
	
func format_time(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))

