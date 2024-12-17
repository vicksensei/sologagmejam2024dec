extends Node2D
class_name enemy
const COIN = preload("res://Prefabs/coin.tscn")

@onready var animation_player = $AnimationPlayer
@onready var area_2d = $Enemy

@export var isMoving = true
@export var animName = "firebat"
@export var firstPatrolPoint: Vector2
var secondPatrolPoint: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.area_entered.connect(onProjectileCollision)
	animation_player.play(animName)
	secondPatrolPoint = position
	if(isMoving):
		var tween = create_tween().set_loops()
		tween.tween_property(self, "position", firstPatrolPoint,1)
		tween.tween_property(self, "position", secondPatrolPoint,1)
	pass # Replace with function body.

func onProjectileCollision(body):
	if body is bullet:
		var coin = COIN.instantiate()
		Global.mainScene.current_level.call_deferred("add_child",coin)
		coin.global_position = global_position
		SignalBus.kill.emit()
		queue_free()
