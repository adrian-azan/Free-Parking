class_name Player extends Node2D

var coordinates: Vector2
var audio_player: AudioStreamPlayer2D

var DEBUG_coordinatesLabel: Label 

var _speed: float


func _ready() -> void:
	DEBUG_coordinatesLabel = $DEBUG/coordinatesLabel
	audio_player = $AudioStreamPlayer2D
	
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
	if Input.is_action_just_pressed("move_left"):
		create_tween().tween_property($Sprite2D, "skew", .36, .2)
		create_tween().tween_property($Sprite2D, "skew", 0, .2).set_delay(.2)
		
	if Input.is_action_just_pressed("move_right"):
		create_tween().tween_property($Sprite2D, "skew", -.36, .2)
		create_tween().tween_property($Sprite2D, "skew", 0, .2).set_delay(.2)
		


	#When Pressed Actions
	#####################
	
	#Play sound when moving
	if moving != Vector2.ZERO and audio_player.playing == false:
		audio_player.stream = ResourceLoader.load("res://ART/SOUND/Vroom noise.mp3")
		audio_player.play()
	elif moving == Vector2.ZERO:
		audio_player.stop()
	
	#Animate movement
	if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
		create_tween().tween_property($Sprite2D, "scale", Vector2(.03, .025), .1)
		create_tween().tween_property($Sprite2D, "scale", Vector2(.03,.03), .1).set_delay(.1)
	
	coordinates += moving
	position = floor(coordinates * 32)
