extends Node2D

var _inCar = true
var DISTANCE_TO_ENTER_CAR: int
@onready var _player = $Player
@onready var _playerCar = $PlayerCar
@onready var _camera = $PlayerCamera


func _ready() -> void:
	_player.visible = false
	DISTANCE_TO_ENTER_CAR = 50
	_camera.reparent(_playerCar)
	

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("SwitchCar") and _player.global_position.distance_to(_playerCar.global_position) < DISTANCE_TO_ENTER_CAR):
		Switch()

	if (_inCar):
		_player.global_position = _playerCar.global_position
		_playerCar.Move(delta)
	else:
		_player.Move(delta)

func Switch():
	_player.visible = !_player.visible
	_inCar = !_inCar
	
	if (_inCar):
		_camera.global_position = _playerCar.global_position
		_camera.reparent(_playerCar)
	else:
		_camera.global_position = _player.global_position
		_camera.reparent(_player)
