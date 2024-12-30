extends Area2D


func _ready():
	body_entered.connect(onEnterWin)
	pass

func onEnterWin(body :CharacterBody2D):
	body.get_child(1).visible = false
	if Global.canEnterDoor:
		if body.name == "SurfaceBody":
			Global.iceCleared = true
		elif body.name == "UnderBody":
			print("fire entered door")
			Global.fireCleared = true
		if Global.iceCleared and Global.fireCleared:
			SignalBus.win.emit()	
