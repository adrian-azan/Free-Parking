extends Label

var currentLap = 0

func _ready() -> void:
	text = "%d" % [currentLap]

func DisplayLap(body: Node2D):
	if (body is not PlayerCar):
		return
		
	currentLap+=1
	text = "%d" % [currentLap]
