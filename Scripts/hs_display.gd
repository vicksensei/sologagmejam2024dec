extends CanvasLayer
@onready var label = $ColorRect2/ColorRect/ScrollContainer/Label
@onready var http_request = $HTTPRequest

var hsurl = "https://victorsensei.com/Games/SoloGameJam/HOFDisplay.php?limit="

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request.request_completed.connect(reieveRequest) 
	var notifier = VisibleOnScreenEnabler2D.new()
	add_child(notifier)
	notifier.screen_entered.connect(makeRequest100)
	notifier.screen_exited.connect(clearScores)
	pass # Replace with function body.

func makeRequest10():
	http_request.request(hsurl + "10")
func makeRequest100():
	http_request.request(hsurl + "100")

func clearScores():
	label.text = "Loading scores..."

func reieveRequest(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8() )
	label.text = body.get_string_from_utf8()
