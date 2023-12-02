extends Node

@onready var timer = $Timer

func start_bash(duration):
	timer.wait_time = duration
	timer.start()
	
func is_bashing():
	return !timer.is_stopped()
