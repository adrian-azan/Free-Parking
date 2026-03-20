extends Label

var currentLap = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "%d" % [currentLap]

func DisplayLap(body: Node2D):
	if (body is not PlayerCar):
		return
		
	currentLap+=1
	text = "%d" % [currentLap]
