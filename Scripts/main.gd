extends Node2D
class_name main
@onready var ui = $UI
@onready var current_level = $CurrentLevel
@onready var animation_player = $CanvasLayer/AnimationPlayer
@onready var console =$UI/consolePanel/Console
@onready var console_panel = $UI/consolePanel

func _ready():
	Global.mainScene = $"."
	SignalBus.clog.connect(log)
	SignalBus.gameStart.emit()
	#checkOS()
	SignalBus.changeScene.connect(setScene)
	var splash = Global.LOGO_SPLASH.instantiate()
	current_level.add_child(splash)
	Global.currentState = Global.gameState.Starting
	animation_player.play("Fadein")	
	await get_tree().create_timer(3).timeout
	setScene(Global.TITLE, false)
	print(JSON.stringify(Global.player_data.currentRunClear))
	

func setScene(nextlevel, hasUI = true):
	animation_player.play("Fadeout")
	await get_tree().create_timer(.5).timeout
	var children = current_level.get_children()
	for child in children:
		child.queue_free()
	var newScene = nextlevel.instantiate()
	current_level.add_child(newScene)
	if newScene is level:
		if newScene.coins == 0:
			hasUI = false
	Global.levelhasUI = hasUI
	ui.visible = hasUI
	
	await get_tree().create_timer(.2).timeout
	animation_player.play("Fadein")

func log(newText:String):
	console.text=newText

func checkOS():
	print("Web: "+ str(	OS.has_feature("web")))
	print("Mobile: "+ str(	OS.has_feature("mobile")))
	print("PC: "+ str(	OS.has_feature("pc")))

#func _input(event):
	#if event.is_action_pressed("console"):
		#console_panel.visible = !console_panel.visible
