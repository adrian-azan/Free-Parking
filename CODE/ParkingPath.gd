@tool
extends Path2D

@export_range(0,100, 1, "exp") var numberOfCars: int:
	set(newValue):
		numberOfCars = newValue
		SetPath()

@export_range(0,7, 1) var spriteFrame: int:
	set(newValue):
		spriteFrame = newValue
		SetPath()

func SetPath():
	for child in get_children():
		child.queue_free()
	
	for i in range(0, numberOfCars):
		var carSprite = AnimatedSprite2D.new()
		carSprite.sprite_frames = ResourceLoader.load("res://ART/SPRITES/Car-Player.tres")
		carSprite.frame = spriteFrame
		
		var pathFollow = PathFollow2D.new()
		pathFollow.add_child(carSprite)
		pathFollow.rotates = false

		add_child(pathFollow)
		pathFollow.progress = (i * 64)
