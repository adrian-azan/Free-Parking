extends Node2D


enum PlayerState {IN_CAR, WALKING, IN_INVENTORY}
var _playerState: PlayerState 

var DISTANCE_TO_ENTER_CAR: int
@onready var _player = $Player
@onready var _playerCar = $PlayerCar
@onready var _camera = $PlayerCamera
@onready var _inventory: Inventory_3dView = $Inventory



func _ready() -> void:
	_player.visible = false
	_playerState = PlayerState.IN_CAR
	DISTANCE_TO_ENTER_CAR = 50
	
	_camera.global_position = _playerCar.global_position + Vector2(0,-100)
	_camera.reparent(_playerCar)
	_camera.zoom = Vector2(1.5,1.5)	

func _physics_process(delta: float) -> void:
	if ((_playerState == PlayerState.IN_CAR or _playerState == PlayerState.WALKING) and	
	Input.is_action_just_pressed("SwitchCar") and _player.global_position.distance_to(_playerCar.global_position) < DISTANCE_TO_ENTER_CAR):
		Switch()

	if Input.is_action_just_pressed("show_inventory"):
		if _playerState == PlayerState.IN_INVENTORY:
			_camera.ShowInventory()
			_playerState = PlayerState.IN_CAR
		elif _playerState == PlayerState.IN_CAR:
			_camera.ShowInventory()
			_playerState = PlayerState.IN_INVENTORY

	if _playerState == PlayerState.IN_INVENTORY:
		_inventory.Move(delta)		

	if (_playerState == PlayerState.IN_CAR):
		_player.global_position = _playerCar.global_position
		_playerCar.Move(delta)

	if (_playerState == PlayerState.WALKING):
		_player.Move(delta)

func Switch():
	_player.visible = !_player.visible
	if _playerState == PlayerState.IN_CAR:
		_playerState = PlayerState.WALKING
	elif _playerState == PlayerState.WALKING:
		_playerState = PlayerState.IN_CAR
	
	if _playerState == PlayerState.IN_CAR:
		#TODO: At somepoint we can use something like PantomCamera to place camera positions
		# Adding -100 here will offset the camera so the car is closer to the bottom of the screen
		_camera.global_position = _playerCar.global_position + Vector2(0,-100)
		_camera.reparent(_playerCar)
		_camera.zoom = Vector2(1.5,1.5)
	else:
		_camera.global_position = _player.global_position
		_camera.reparent(_player)
		_camera.zoom = Vector2(4,4)
