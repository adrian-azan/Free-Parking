@tool
extends Path2D

@export_range(0,500, 1, "exp") var numberOfCars: int:
	set(newValue):
		numberOfCars = newValue
		SetPath()

@export_range(0,1000, 1) var distance: int:
	set(newValue):
		distance = newValue
		SetPath()

func _ready() -> void:
	call_deferred("SetPath")

func SetPath():
	for child in get_children():
		child.queue_free()
	
	for i in range(0, numberOfCars):
		var carSprite = (ResourceLoader.load("res://SCENES/CUT_SCENES/Intro_Cut_Scene/StreetPiece.tscn") as PackedScene).instantiate()

		var pathFollow = PathFollow2D.new()
		pathFollow.add_child(carSprite)
		pathFollow.rotates = false

		add_child(pathFollow)
		
		pathFollow.progress = (i * distance)
