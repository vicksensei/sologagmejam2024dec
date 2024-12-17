extends Node2D

const fire_bullet = preload("res://Prefabs/fire_bullet.tscn")
const ice_bullet = preload("res://Prefabs/ice_bullet.tscn")
const death_particle = preload("res://Prefabs/death_particle.tscn")

@onready var surface_body = $SurfaceBody
@onready var surface_sprite = $SurfaceBody/Sprite2D
@onready var under_body = $UnderBody
@onready var under_sprite = $UnderBody/Sprite2D2
@onready var animation_player = $AnimationPlayer
@onready var ice_coyote_timer = $SurfaceBody/IceCoyoteTimer
@onready var fire_coyote_timer = $UnderBody/FireCoyoteTimer

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const JUMP_VELOCITY_INVERT = JUMP_VELOCITY *-1

var facing = 1

var wasIceOnFloor = false
var wasFireOnFloor = false

var canFireJump = false
var canIceJump = false

func _ready():
	SignalBus.die.connect(onDead)	
	animation_player.play("idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		onPause()
	if Global.currentState == Global.gameState.Playing:
		if not surface_body.is_on_floor() and Global.iceCleared == false:
			surface_body.velocity += surface_body.get_gravity() * delta
			if Input.is_action_just_released("jump") and surface_body.velocity.y <0:
				surface_body.velocity.y = 0;
			
		if not under_body.is_on_ceiling() and Global.fireCleared == false:
			under_body.velocity += under_body.get_gravity() * delta * -1			
			if Input.is_action_just_released("jump")and under_body.velocity.y >0:
				under_body.velocity.y = 0;
		
		if Input.is_action_just_pressed("jump"):
			if (surface_body.is_on_floor() or ice_coyote_timer.is_stopped() == false) and Global.iceCleared == false:
				animation_player.play("idle")
				surface_body.velocity.y = JUMP_VELOCITY
				SignalBus.jump.emit()
			if (under_body.is_on_ceiling() or fire_coyote_timer.is_stopped() == false) and Global.fireCleared == false:
				animation_player.play("idle")
				under_body.velocity.y = JUMP_VELOCITY *-1
				SignalBus.jump.emit()


		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			if Global.iceCleared == false:
				surface_body.velocity.x = direction * SPEED
			if Global.fireCleared == false: 
				under_body.velocity.x = direction * SPEED
			animation_player.play("walking")
		else:
			if Global.iceCleared == false:
				surface_body.velocity.x = move_toward(surface_body.velocity.x, 0, SPEED)	
			if Global.fireCleared == false: 
				under_body.velocity.x = move_toward(under_body.velocity.x, 0, SPEED)
			animation_player.play("idle")
		
		if direction < 0:
			surface_sprite.flip_h = true
			under_sprite.flip_h = true
			facing = -1	
		elif direction > 0:
			surface_sprite.flip_h = false
			under_sprite.flip_h = false
			facing = 1
						
		if Input.is_action_just_pressed("Shoot"):
			if Global.projectileCount > 0:
				SignalBus.shoot.emit()
				if Global.iceCleared == false:
					var newIceBullet = ice_bullet.instantiate()
					surface_body.get_parent().add_child(newIceBullet)
					newIceBullet.global_position = surface_body.global_position
					newIceBullet.direction = facing
					newIceBullet.checkDirection()
				
				if Global.fireCleared == false: 
					var newBullet = fire_bullet.instantiate()
					under_body.get_parent().add_child(newBullet)
					newBullet.global_position = under_body.global_position
					newBullet.direction = facing
					newBullet.checkDirection()
				Global.projectileCount -= 1
				SignalBus.shotUpdate.emit()
		if Global.iceCleared == false:
			wasIceOnFloor = surface_body.is_on_floor()
			surface_body.move_and_slide()
			if wasIceOnFloor and not surface_body.is_on_floor():
				ice_coyote_timer.start()
			
		
		if Global.fireCleared == false:
			wasFireOnFloor = under_body.is_on_ceiling() 
			under_body.move_and_slide()
			if wasFireOnFloor and not under_body.is_on_ceiling():
				fire_coyote_timer.start()
		
		if Input.is_action_just_pressed("Reset"):
			onRestart()
		#if Input.is_action_just_pressed("ui_focus_next"):
			#SignalBus.win.emit()	
			
func onDead():	
	SignalBus.dieSound.emit()
	Global.currentState = Global.gameState.Dead
	surface_sprite.visible = false
	under_sprite.visible = false
	doDeathAnimation()
	await get_tree().create_timer(1.5).timeout
	SignalBus.changeScene.emit(Global.TITLE)
	pass
	
func onRestart():
	SignalBus.dieSound.emit()
	Global.currentState = Global.gameState.Dead
	surface_sprite.visible = false
	under_sprite.visible = false
	doDeathAnimation()
	await get_tree().create_timer(1.5).timeout
	SignalBus.changeScene.emit(Global.levels[Global.currentLevel])
	
func doDeathAnimation():
	spawn_death_bloom(surface_body.global_position)
	spawn_death_bloom(under_body.global_position)
	await get_tree().create_timer(.5).timeout
	spawn_death_bloom(surface_body.global_position)
	spawn_death_bloom(under_body.global_position)
	await get_tree().create_timer(.5).timeout
	spawn_death_bloom(surface_body.global_position)
	spawn_death_bloom(under_body.global_position)
	await get_tree().create_timer(1.5).timeout
	

func spawn_death_bloom(originalPos):
	spawn_death_particle(Vector2(1,1), originalPos)
	spawn_death_particle(Vector2(1,-1), originalPos)	
	spawn_death_particle(Vector2(-1,1), originalPos)
	spawn_death_particle(Vector2(-1,-1), originalPos)	
	spawn_death_particle(Vector2(1,0), originalPos)
	spawn_death_particle(Vector2(-1,0), originalPos)
	spawn_death_particle(Vector2(0,-1), originalPos)
	spawn_death_particle(Vector2(0,1), originalPos)

func spawn_death_particle(direction, originalPos):
	var newParticle = death_particle.instantiate()
	Global.mainScene.current_level.add_child(newParticle)
	newParticle.direction = direction.normalized()
	newParticle.global_position = originalPos
	
func onPause():
	if Global.currentState == Global.gameState.Paused:
		Global.currentState = Global.gameState.Playing
		SignalBus.pauseToggle.emit()

	elif Global.currentState == Global.gameState.Playing:
		Global.currentState = Global.gameState.Paused
		SignalBus.pauseToggle.emit()

	if Global.currentState == Global.gameState.Dead:
		pass
