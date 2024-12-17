extends Node

@onready var sound = $sound

@onready var music = $music
const JRPG_PIANO = preload("res://audio/JRPG Piano.mp3")
const WE_WISH_YOU_A_MERRY_CHRISTMAS = preload("res://audio/we-wish-you-a-merry-christmas-happy-remix-background-intro-theme-265842.mp3")
const BOOM = preload("res://audio/boom.wav")
const COIN = preload("res://audio/coin.wav")
const JUMP = preload("res://audio/jump.wav")
const LOSE = preload("res://audio/lose.wav")
const PICKUP = preload("res://audio/pickup.wav")
const SHOOT = preload("res://audio/shoot.wav")
const WIN = preload("res://audio/win.wav")
const BLIP = preload("res://audio/blip.wav")

func _ready():
	startMusic()
	
	SignalBus.coinPickup.connect(onAddCoin)
	SignalBus.dieSound.connect(onDie)
	SignalBus.powerPickup.connect(onPickup)
	SignalBus.openDoor.connect(onOpenDoor)
	SignalBus.jump .connect(onJump)
	SignalBus.kill .connect(onKill)
	SignalBus.shoot .connect(onShoot)
	SignalBus.hover .connect(onHover)
	SignalBus.startMusic.connect(startMusic)
	SignalBus.victory.connect(WinBGMusic)
	pass # Replace with function body.

func startMusic():
	if music.playing == false:			
		music.stream = JRPG_PIANO
		music.play()

func WinBGMusic():
		music.stream = WE_WISH_YOU_A_MERRY_CHRISTMAS
		music.play()
	
func onHover():	
	playSoundRandomPitch(BLIP)
		
func onAddCoin():
	playSoundRandomPitch(COIN)

func onShoot():
	sound.stream = SHOOT
	sound.play()
	
func onPickup():
	sound.stream = PICKUP
	sound.play()
	
func onKill():
	playSoundRandomPitch(BOOM)

func onJump():
	playSoundRandomPitch(JUMP)

func onDie():	
	sound.stream = LOSE
	music.stop()
	sound.play()
	await get_tree().create_timer(1).timeout
	pass
func onOpenDoor():
	sound.stream = WIN
	sound.play()
func onWin():
	pass
	

func playSoundRandomPitch(clip, min =0.8, max =1.2):
	var pitch = randf_range(min, max)
	sound.stream = clip
	sound.set_pitch_scale( pitch)
	sound.play()
