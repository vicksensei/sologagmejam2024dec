extends Node


func _ready():
	await get_tree().create_timer(3).timeout
	SignalBus.win.emit()	
