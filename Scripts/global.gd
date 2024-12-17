extends Node

var levelMaxCoins =0
var levelCollectedCoins =0
var projectileCount =0
var canEnterDoor = false
var fireCleared = false
var iceCleared = false

var currentLevel = 0
var mainScene:main
@onready var rootScene = $"."

const LOGO_SPLASH = preload("res://Levels/logo_splash.tscn")
const TITLE = preload("res://Levels/titleweb.tscn")
const LEVEL_TUTORIAL = preload("res://Levels/levelTutorial.tscn")
const LEVEL_TUTORIAL_2 = preload("res://Levels/levelTutorial2.tscn")
const LEVEL_TEST = preload("res://Levels/levelTest.tscn")
const LEVEL_1 = preload("res://Levels/level1.tscn")
const LEVEL_2 = preload("res://Levels/level2.tscn")
const LEVEL_3 = preload("res://Levels/level3.tscn")
const LEVEL_4 = preload("res://Levels/level4.tscn")
const LEVEL_5 = preload("res://Levels/level5.tscn")
const LEVEL_6 = preload("res://Levels/level6.tscn")
const LASTLEVEL = preload("res://Levels/lastlevel.tscn")
const LEVEL_WARNING = preload("res://Levels/levelWarning.tscn")
const LEVEL_HARD = preload("res://Levels/levelHard.tscn")
const LEVEL_MID = preload("res://Levels/levelMid.tscn")
const WINSCREEN = preload("res://Levels/win_screen.tscn")

var levels = [ LEVEL_TUTORIAL, 
LEVEL_TUTORIAL_2, 
LEVEL_TEST, 
LEVEL_1, 
LEVEL_2, 
LEVEL_3, 
LEVEL_MID,
LEVEL_HARD,
LEVEL_WARNING,
LEVEL_4, 
LEVEL_5, 
LEVEL_6, 
LASTLEVEL,
WINSCREEN ]

enum gameState {
	Starting,
	Menu,
	Paused,
	Playing,
	Dead
}

var currentState:gameState

func _ready():
	currentState = gameState.Starting
	SignalBus.win.connect(onWin)

func onDead():
	currentLevel = 0

func onWin():
	currentLevel += 1
	if(currentLevel < levels.size()):
		SignalBus.changeScene.emit(levels[currentLevel])
		