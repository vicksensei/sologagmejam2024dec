extends Node2D
class_name main
@onready var ui = $UI
@onready var current_level = $CurrentLevel
@onready var animation_player = $CanvasLayer/AnimationPlayer

func _ready():
	Global.mainScene = $"."
	SignalBus.changeScene.connect(setScene)
	var splash = Global.LOGO_SPLASH.instantiate()
	current_level.add_child(splash)
	Global.currentState = Global.gameState.Starting
	animation_player.play("Fadein")	
	await get_tree().create_timer(3).timeout
	setScene(Global.TITLE, false)
	

func setScene(level, hasUI = true):
	animation_player.play("Fadeout")
	await get_tree().create_timer(.5).timeout
	var children = current_level.get_children()
	for child in children:
		child.queue_free()
	var newScene = level.instantiate()
	current_level.add_child(newScene)
	if hasUI:
		ui.visible = true
	
	await get_tree().create_timer(.2).timeout
	animation_player.play("Fadein")
	
