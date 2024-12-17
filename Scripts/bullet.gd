extends Area2D
class_name bullet
@onready var sprite_2d = $Sprite2D

var direction = 1
var speed = 300

func _ready():
	area_entered.connect(onCollision)
	await get_tree().create_timer(3).timeout
	queue_free()
	pass 

func _process(delta):
	position += transform.x * speed * delta * direction
		
	pass
func checkDirection():	
	if direction < 0:
		sprite_2d.flip_v = true

func onCollision(body):
	#print(body.name + "- bullet collision")
	if body.name == "Enemy":
			queue_free()
	#if body is enemy:
		#queue_free()
		#print(body.name + "- enemy bullet collision")
	pass
