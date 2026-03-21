extends Node2D

@onready var player = $PlayerAndCar/Player
@onready var tileMap = $TileMap

var count = 1

var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)

	timer.wait_time = 2
	timer.start()
	timer.one_shot = false
	
	timer.connect("timeout", SpawnCars)
	

func _process(delta: float) -> void:
	LabelOverlay.SetLabel(2, "%d" % [timer.time_left])

func SpawnCars():
	var newCar = (ResourceLoader.load("res://SCENES/OtherCar.tscn") as PackedScene).instantiate() as CharacterBody2D
	newCar.velocity = player.velocity * .95 if player.velocity.x > 400 else Vector2(600,0)
	
	var spawns = [$End/Spawn1.global_position,$End/Spawn2.global_position,$End/Spawn3.global_position]
	newCar.global_position = spawns.pick_random() 
	add_child(newCar)

func SpawnMoreRoad(body: Node2D):
	count += 1
	tileMap.set_pattern(0, Vector2(count * 33,-24),tileMap.tile_set.get_pattern(3))
	
	$End.global_position += Vector2(33*32,0)
