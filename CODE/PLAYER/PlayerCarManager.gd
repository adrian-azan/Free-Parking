extends Node2D

var _inCar = true
@onready var player = $Player
@onready var playerCar = $PlayerCar
@onready var camera = $PlayerCamera

func _ready() -> void:
	player.visible = false
	camera.reparent(playerCar)
	

func _physics_process(delta: float) -> void:
	LabelOverlay.SetLabel(3, "%d" %[player.global_position.distance_to(playerCar.global_position)])

	if (Input.is_action_just_pressed("SwitchCar") and player.global_position.distance_to(playerCar.global_position) < 50):
		Switch()

	if (_inCar):
		player.global_position = playerCar.global_position
		playerCar.Move(delta)
	else:
		player.Move(delta)

func Switch():
	player.visible = !player.visible
	_inCar = !_inCar
	
	if (_inCar):
		camera.global_position = playerCar.global_position
		camera.reparent(playerCar)
	else:
		camera.global_position = player.global_position
		camera.reparent(player)
