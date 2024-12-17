extends Node2D

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("WIN")
	SignalBus.victory.emit()
	
	await get_tree().create_timer(20).timeout
	Global.currentLevel = 0
	SignalBus.changeScene.emit(Global.TITLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
