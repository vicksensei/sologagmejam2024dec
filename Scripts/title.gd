extends Node2D
@onready var startButton = $CanvasLayer/CenterContainer/Button


func _ready():
	startButton.mouse_entered.connect(buttonSound)
	startButton.pressed.connect(onButton)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		onButton()

func onButton():
	SignalBus.changeScene.emit(Global.levels[Global.currentLevel])

func buttonSound():
	SignalBus.hover.emit()
