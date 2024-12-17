extends Area2D
@onready var animation_player = $AnimationPlayer

func _ready():
	body_entered.connect(touchPower)
	animation_player.play("spin")
	

func touchPower(body):
	Global.projectileCount +=1
	SignalBus.powerPickup.emit()
	queue_free()
	pass
