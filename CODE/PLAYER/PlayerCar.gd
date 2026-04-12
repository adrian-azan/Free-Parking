class_name PlayerCar extends CharacterBody2D


###
# Debug Stuff (Its often handy to add some labels and stuff to view values while playing.
#				AAAAAaaand I just thought of another handy little tool. Super simple screen overlay
#				thats like 3 columns of 6 rows of labels. Smack whatever you need in that script
#				without having to worry about the player class having a shit ton of labels
#				Ok lets do it  - 3/15/25 - 10:02pm Ok did it 3/17. Now there is a global
#				Node that you can add a string to get it to show up on screen. Called it LabelOverlay)
###



###
# Little Tools (Ok idealy I'd like to use the tools I wrote in c# here, but until then I'm putting some tools
#					That I have found most nodes need but dont have, will go here
###
var audio_player: AudioStreamPlayer2D


###
# Vehicle Movement (Tid bit, usually if im '@export'ing, its also an indicator I can play around
# 					withthese values in the _ready method to see it do different stuff to the player)
###

## Set a limit to the players final velocity for the X-Axis. Vector2(min, max)
@export var velocityXClamp: Vector2
## Set a limit to the players final velocity for the Y-Axis. Vector2(min, max)
@export var velocityYClamp: Vector2
## Set the limit to the players acceleration in all directions
@export var _maxAcceleration: float

var _currentAcceleration: Vector2 
var _acceleration: float

###
# "Ok what the heck are these??" I hear you saying. Well, certainly cant claim this is not a hammer
# looking for a nail, but this is my solution to "Decelerating". Ok here was the issue: calculating the value 
# for where the player is going is easy. They hit right they go right, they hit left they go left. DECELERATING is
# a bit different right? cause I want to decelerate when I hit NO buttons. So how can I tell what direction to 
# send the player to make them slow down? Lets say I just make it negative. Like say I'm going -10 (left) and I stop.
# Id expect the acceleration to then go to -9, -8... -2, -1, 0 and then stop there. But then how do I get the Deceleration
# to be positive if I was going left and then negative if I was going right. I just want what ever value acceleration
# currently is to head towards 0...And then it hit me. Tween go value I say 0_0 Tween not care what initial value is
# So I made a tween to do just that. 
#
# "But WHHhhhhyyYYYYyy are there 2?" BECAUSE X AND Y DONT EFFECT EACHOTHER. I messed this logic up a few times making
# this acceleration based. The x and why should work independnt to eachother. So if I'm not pressing left or right I am
# slowing down horizontally but I could be SHMOOOVING up and down. I also put these in their own variables cause I need
# to keep track of them. Mostly to check if they are "valid" (finished) or if I need to kill it early
###
var SPEEDING_DOWN_X: Tween
var SPEEDING_DOWN_Y: Tween
var _decelerationTime: float

###
# Stuff about the node
###
@onready var sprite: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	audio_player = $AudioStreamPlayer2D
	
	SPEEDING_DOWN_X = create_tween()
	SPEEDING_DOWN_Y = create_tween()
	SPEEDING_DOWN_X.kill()
	SPEEDING_DOWN_Y.kill()
	_decelerationTime = .5
	
	_maxAcceleration = 40.0 if _maxAcceleration == 0 else _maxAcceleration;
	_currentAcceleration = Vector2(0,0)
	_acceleration = _maxAcceleration / 2;
	
	# For Christian -> This is so that if we don't set the value in the editor, then -250,250 is the default velocity value
	velocityXClamp = Vector2(-100,100) if velocityXClamp == Vector2.ZERO else velocityXClamp
	velocityYClamp = Vector2(-100,100) if velocityYClamp == Vector2.ZERO else velocityYClamp

func Move(delta: float) -> void:

	#When Pressed Actions
	#####################
	
	var moving: Vector2 = Vector2.ZERO	
	moving.y = Input.get_axis("move_up", "move_down")
	moving.x = Input.get_axis("move_left", "move_right")
			
		
	if (moving.x != 0):
		SPEEDING_DOWN_X.kill()
		_currentAcceleration += _acceleration * moving.x * Vector2(1,0) * delta
		
	if (moving.y != 0):
		SPEEDING_DOWN_Y.kill()
		_currentAcceleration += _acceleration * moving.y * Vector2(0,1) * delta
		
	if (moving.x == 0 and !SPEEDING_DOWN_X.is_valid()):
		SPEEDING_DOWN_X = create_tween()
		SPEEDING_DOWN_X.tween_property(self, "velocity:x", 0, _decelerationTime)
		_currentAcceleration.x = 0
		
	if (moving.y == 0 and !SPEEDING_DOWN_Y.is_valid()):
		SPEEDING_DOWN_Y = create_tween()
		SPEEDING_DOWN_Y.tween_property(self, "velocity:y", 0, _decelerationTime)
		_currentAcceleration.y = 0
		

	_currentAcceleration.x = clamp(_currentAcceleration.x, -_maxAcceleration, _maxAcceleration)
	_currentAcceleration.y = clamp(_currentAcceleration.y, -_maxAcceleration, _maxAcceleration)
	
	if (!SPEEDING_DOWN_X.is_valid() || !SPEEDING_DOWN_Y.is_valid()):
		velocity += _currentAcceleration
		velocity.x = clamp(velocity.x, velocityXClamp.x, velocityXClamp.y)
		velocity.y = clamp(velocity.y, velocityYClamp.x, velocityYClamp.y)

	
	#Play sound when moving
	if moving != Vector2.ZERO and audio_player.playing == false:
		audio_player.stream = ResourceLoader.load("res://ART/SOUND/Vroom noise.mp3")
		#audio_player.play()
	elif moving == Vector2.ZERO:
		audio_player.stop()
	
	
	#Straight Left or Right
	if moving.x == 1 and moving.y == 0:
		sprite.frame = 3
	if moving.x == -1 and moving.y == 0:
		sprite.frame = 7
		
	#Straight Up or Down
	if moving.y == 1 and moving.x == 0:
		sprite.frame = 5
	if moving.y == -1 and moving.x == 0:
		sprite.frame = 1
		
	#Diagnols
	#Sprite will only change to go diagnol after we've reached half of the max/min velocity in any direction
	#DownRight
	if (moving.y == 1 and moving.x == 1) and (velocity.y >= velocityYClamp.y / 2 and velocity.x >= velocityXClamp.y / 2):
		sprite.frame = 4
	#DownLeft
	if (moving.y == 1 and moving.x == -1) and (velocity.y >= velocityYClamp.y / 2 and velocity.x <= velocityXClamp.x / 2):
		sprite.frame = 6	
	#UpRight
	if moving.y == -1 and moving.x == 1 and (velocity.y <= velocityYClamp.x / 2 and velocity.x >= velocityXClamp.y / 2):
		sprite.frame = 2
	#UpLeft
	if moving.y == -1 and moving.x == -1 and (velocity.y <= velocityYClamp.x / 2 and velocity.x <= velocityXClamp.x / 2):
		sprite.frame = 0
	
	
	move_and_slide()
