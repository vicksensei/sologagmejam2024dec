extends Node2D
@onready var startButton = $CanvasLayer/CenterContainer/Button
@onready var hs_display = $CanvasLayer/HSDisplay
@onready var exit_button = $CanvasLayer/HSDisplay/Exit
@onready var high_scores_show =$CanvasLayer/ShowHS
@onready var erase = $CanvasLayer/erase
@onready var o_slabel = $CanvasLayer/OSlabel

func _ready():
	startButton.mouse_entered.connect(buttonSound)
	exit_button.mouse_entered.connect(buttonSound)
	high_scores_show.mouse_entered.connect(buttonSound)
	erase.mouse_entered.connect(buttonSound)
	startButton.pressed.connect(onButton)
	exit_button.pressed.connect(onHideHS)
	high_scores_show.pressed.connect(onShowHS)
	erase.pressed.connect(onErase)
	Global.levelhasUI = false
	SignalBus.levelStart.emit()
	
	print("Web: "+ str(	OS.has_feature("web")))
	print("Mobile: "+ str(	OS.has_feature("mobile")))
	print("PC: "+ str(	OS.has_feature("pc")))
	o_slabel.text = ""
	if OS.has_feature("web"):
		o_slabel.text += "Web \n"
	if Global.isMobile:
		o_slabel.text += "Mobile \n"
	if OS.has_feature("web_ios"):
		o_slabel.text += "iOS \n"
	if OS.has_feature("web_android"):
		o_slabel.text += "Android \n"
	if OS.has_feature("pc"):
		o_slabel.text += "PC \n"
	onReset()
	

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		onButton()

func onErase():
	SignalBus.erase.emit()

func onButton():
	SignalBus.changeScene.emit(Global.levels[Global.currentLevel])

func buttonSound():
	SignalBus.hover.emit()

func onReset():
	Global.currentLevel = Global.player_data.currentRunClear
	Global.deaths = Global.player_data.currentDeaths
func onShowHS():
	hs_display.visible = true

func onHideHS():
	hs_display.visible = false
