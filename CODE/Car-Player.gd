extends Node2D

var coordinates: Vector2
var audio_player: AudioStreamPlayer2D
var car_player: Node2D

var DEBUG_coordinatesLabel: Label 

var _speed: float


func _ready() -> void:
	DEBUG_coordinatesLabel = $DEBUG/coordinatesLabel
	audio_player = $AudioStreamPlayer2D
	car_player = $AnimatedSprite2D
	
	_speed = .1


func _process(delta: float) -> void:
	DEBUG_coordinatesLabel.text = "(%d, %d)" % [coordinates.x, coordinates.y]	
	
	
	var moving: Vector2 = Vector2.ZERO	
	if Input.is_action_pressed("move_up"):
		moving.y -= _speed
	if Input.is_action_pressed("move_down"):
		moving.y += _speed
	if Input.is_action_pressed("move_right"):
		moving.x += _speed
	if Input.is_action_pressed("move_left"):
		moving.x -= _speed
		

	# Per Frame Actions
	###################		
	
	
	#Animate movement
	if Input.is_action_just_pressed("move_up"):
		car_player.frame = 1
		
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
		car_player.frame = 2
		
	if Input.is_action_just_pressed("move_right"):
		car_player.frame = 3
		
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
		car_player.frame = 4
		
	if Input.is_action_just_pressed("move_down"):
		car_player.frame = 5
		
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
		car_player.frame = 6
	
	if Input.is_action_just_pressed("move_left"):
		car_player.frame = 7
		
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
		car_player.frame = 0

	#When Pressed Actions
	#####################
	
	#Play sound when moving
	if moving != Vector2.ZERO and audio_player.playing == false:
		audio_player.stream = ResourceLoader.load("res://ART/SOUND/Vroom noise.mp3")
		audio_player.play()
	elif moving == Vector2.ZERO:
		audio_player.stop()
	
	#Animate movement
	# if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
		# pass
	
	coordinates += moving
	position = floor(coordinates * 32)
