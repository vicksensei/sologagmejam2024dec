extends Control

@onready var button = $Panel/CenterContainer/Button
@onready var pause = $Panel/VBoxContainer2/Pause
@onready var fire = $Panel/VBoxContainer2/Fire
@onready var restart = $Panel/VBoxContainer2/Restart
@onready var move = $Panel/VBoxContainer/Move
@onready var jump = $Panel/VBoxContainer/Jump
@onready var mobile = $Panel/Mobile

func _ready():
	button.pressed.connect(onExitToMenu)
	if Global.isMobile:
		pause.visible=false
		fire.visible=false
		restart.visible=false
		move.visible=false
		jump.visible=false
		mobile.visible = true

func onExitToMenu():
	print("exit Pressed")
	Global.consoleLog("Exit Pressed")
	visible = false
	Global.mainScene.setScene(Global.TITLE, false)
