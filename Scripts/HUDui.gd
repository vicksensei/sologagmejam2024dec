extends CanvasLayer
@onready var coins = $Coins
@onready var shots = $Shots
@onready var level = $Level
@onready var pause_menu = $PauseMenu


func updateCoin():
	if Global.levelMaxCoins > 0:
		coins.text = "Coins: "+ str(Global.levelCollectedCoins) + "/" +str( Global.levelMaxCoins)
	else:
		coins.text = ""

func updateShots():
	if Global.projectileCount > 0:
		shots.text = "Projectiles: " + str(Global.projectileCount)	
	else:
		shots.text = ""

func updateLevel():
	level.text = "Level: " + str(Global.currentLevel)
	

func _ready():
	SignalBus.coinPickup.connect(updateCoin)
	SignalBus.powerPickup.connect(updateShots)
	SignalBus.shotUpdate.connect(updateShots)
	SignalBus.levelStart.connect(updateCoin)
	SignalBus.levelStart.connect(updateLevel)
	SignalBus.pauseToggle.connect(togglePause)
	updateShots()
	updateCoin()
	updateLevel()


func togglePause():
	pause_menu.visible = !pause_menu.visible
