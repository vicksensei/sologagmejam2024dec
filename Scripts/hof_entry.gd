extends Control
@onready var http_request = $HTTPRequest
@onready var text_edit = $CenterContainer/Panel/TextEdit
@onready var center_container = $CenterContainer

@onready var total_death_value = $CenterContainer/Panel/TotalDeathValue
@onready var okay = $CenterContainer/Panel/Okay
@onready var exit = $CenterContainer/Panel/Exit
@onready var animation_player = $AnimationPlayer

var hsurl = "https://victorsensei.com/Games/SoloGameJam/HOFAdd.php"


func _ready():
	center_container.visible = false
	total_death_value.visible = false
	okay.pressed.connect(onOkay)
	okay.mouse_entered.connect(buttonSound)
	exit.pressed.connect(onExit)
	exit.mouse_entered.connect(buttonSound)
	http_request.request_completed.connect(reieveRequest) 
	SignalBus.showHSentry.connect(onShow)

func onShow():	
	center_container.visible = true
	animation_player.play("HighScoreAnimation")

func animateLabel():
	total_death_value.visible = true
	for i in range(Global.deaths):
		total_death_value.text = str(i)
		await get_tree().create_timer(.01).timeout

func buttonSound():
	SignalBus.hover.emit()

func onExit():
	SignalBus.changeScene.emit(Global.TITLE)
	pass
func onOkay():
	makeRequest()
	okay.disabled = true
	pass


func makeRequest():
	print(text_edit.text)
	var nameP= text_edit.text
	var deathsP = Global.deaths
	
	var body = "namePost=%s&deathsPost=%d" % [nameP, deathsP]
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	http_request.request(hsurl, headers, HTTPClient.METHOD_POST, body)
	
func reieveRequest(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8() )
	#label.text = body.get_string_from_utf8()
