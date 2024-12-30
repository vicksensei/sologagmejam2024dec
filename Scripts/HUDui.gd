extends CanvasLayer
@onready var coins = $Coins
@onready var shots = $Shots
@onready var level = $Level
@onready var deaths = $Deaths
@onready var pause_menu =$PauseMenu

func updateAllUI():
	updateCoin()
	updateDeaths()
	updateLevel()
	updateShots()

func updateCoin():
	if Global.levelMaxCoins > 0 and Global.isWinScreen == false:
		coins.text = "Coins: "+ str(Global.levelCollectedCoins) + "/" +str( Global.levelMaxCoins)
	else:
		coins.text = ""

func updateShots():
	if Global.projectileCount > 0 and Global.isWinScreen == false:
		shots.text = "Projectiles: " + str(Global.projectileCount)	
	else:
		shots.text = ""

func updateLevel():
	if Global.isWinScreen == false:
		level.text = "Level: " + str(Global.currentLevel + 1)
	else:
		level.text = ""
func updateDeaths():
	
	if Global.deaths > 0:
		deaths.text = "Deaths:" + str(Global.deaths)
	else:
		deaths.text = ""
	

func _ready():
	SignalBus.coinPickup.connect(updateCoin)
	SignalBus.powerPickup.connect(updateShots)
	SignalBus.shotUpdate.connect(updateShots)
	SignalBus.die.connect(updateDeaths)
	SignalBus.levelStart.connect(updateAllUI)
	SignalBus.pauseToggle.connect(togglePause)
	SignalBus.victory.connect(updateAllUI)
	updateShots()
	updateCoin()
	updateLevel()
	updateDeaths()

func togglePause():
	pause_menu.visible = !pause_menu.visible
