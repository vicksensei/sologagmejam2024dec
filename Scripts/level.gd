extends Node
@export var coins: int
@export var black_door: Vector2i
@export var white_door: Vector2i

@onready var tile_map_layer = $TileMapLayer

func _ready():
	Global.canEnterDoor = false
	Global.fireCleared = false
	Global.iceCleared = false
	Global.currentState = Global.gameState.Playing
	Global.levelMaxCoins = coins
	Global.levelCollectedCoins = 0
	Global.projectileCount = 0
	SignalBus.shotUpdate.emit()
	SignalBus.levelStart.emit()
	SignalBus.startMusic.emit()
	SignalBus.openDoor.connect(onOpenDoor)
	
	
func onOpenDoor():
	tile_map_layer.set_cell(black_door,0,Vector2i(4,2))
	tile_map_layer.set_cell(white_door,0,Vector2i(4,3))
	Global.canEnterDoor = true
	
