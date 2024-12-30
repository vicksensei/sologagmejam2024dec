extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(onPlayerEnter)
	pass # Replace with function body.

func onPlayerEnter(_body):
	if not Global.currentState == Global.gameState.Dead: 
		Global.currentState = Global.gameState.Dead
		SignalBus.die.emit()
	
