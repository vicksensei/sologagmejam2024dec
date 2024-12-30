extends CanvasLayer
@onready var left = $Control/Left
@onready var right = $Control/Right
@onready var pause = $Control/Pause
@onready var jump = $Control/Jump
@onready var shoot = $Control/Shoot
@onready var reset = $Control/Reset

@onready var control = $Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#SignalBus.changeScene.connect()
	SignalBus.shotUpdate.connect(updateShootButton)
	SignalBus.powerPickup.connect(updateShootButton)
	SignalBus.levelStart.connect(hideControls)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#
func _input(event):
	if event is InputEventMouseButton and Global.levelhasUI:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if not Rect2(left.position, left.texture_normal.get_size()).has_point(event.position) \
			and not Rect2(right.position, right.texture_normal.get_size()).has_point(event.position)\
			and not Rect2(pause.position, pause.texture_normal.get_size()).has_point(event.position)\
			and not Rect2(jump.position, jump.texture_normal.get_size()).has_point(event.position)\
			and not Rect2(shoot.position, shoot.texture_normal.get_size()).has_point(event.position)\
			and not Rect2(reset.position, reset.texture_normal.get_size()).has_point(event.position):
				updateUI()

func updateUI():
	if OS.has_feature("mobile"):
		control.visible = !control.visible
func hideControls():
	control.visible = false
	
func updateShootButton():
	if Global.projectileCount > 0:
		shoot.visible = true
	else:
		shoot.visible = false
		
