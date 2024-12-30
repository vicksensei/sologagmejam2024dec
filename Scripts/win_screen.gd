extends Node2D

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("WIN")
	Global.isWinScreen = true
	Global.player_data.currentDeaths = Global.deaths
	SignalBus.victory.emit()
	
	await get_tree().create_timer(10).timeout
	Global.player_data.highestClear = Global.currentLevel
	Global.currentLevel = 0
	Global.player_data.currentRunClear = 0
	if Global.player_data.currentDeaths < Global.player_data.lowestDeaths:
		Global.player_data.lowestDeaths = Global.player_data.currentDeaths
	SignalBus.saveGame.emit()
	SignalBus.showHSentry.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
