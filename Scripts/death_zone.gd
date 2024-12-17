extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(onPlayerEnter)
	pass # Replace with function body.

func onPlayerEnter(_body):
	SignalBus.die.emit()
	
