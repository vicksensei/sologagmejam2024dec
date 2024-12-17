extends Area2D
@onready var animation_player = $AnimationPlayer

@export var isBlack = false
@onready var white = $Sprite2D
@onready var black = $Sprite2D2

func _ready():
	body_entered.connect(touchCoin)
	animation_player.play("roatate")
	if isBlack:
		white.visible = false
		black.visible = true
	else:
		white.visible = true
		black.visible =false 
	

func touchCoin(body):
	Global.levelCollectedCoins+=1
	if Global.levelCollectedCoins == Global.levelMaxCoins:
		SignalBus.openDoor.emit()
	SignalBus.coinPickup.emit()
	queue_free()
	pass
