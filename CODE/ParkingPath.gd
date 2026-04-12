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
		
@export var zIndex: int:
	set(newValue):
		zIndex = newValue
		SetPath()


func SetPath():
	for child in get_children():
		child.queue_free()
	
	for i in range(0, numberOfCars):
		var carSprite = AnimatedSprite2D.new()
		carSprite.sprite_frames = ResourceLoader.load("res://ART/SPRITES/Cars/Car-Player.tres")
		carSprite.animation = ["blue", "red", "green", "puke","default"].pick_random()
		carSprite.frame = spriteFrame
		carSprite.z_index = zIndex
		
		var pathFollow = PathFollow2D.new()
		pathFollow.add_child(carSprite)
		pathFollow.rotates = false

		add_child(pathFollow)
		pathFollow.progress = (i * 64)
