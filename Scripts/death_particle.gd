extends Node2D

var speed = 100
var direction

func _ready():
	$AnimationPlayer.play("destroyParticle")
	await get_tree().create_timer(15.0).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mult = delta *speed
	position+= Vector2(direction.x * mult, direction.y *mult)
	pass
