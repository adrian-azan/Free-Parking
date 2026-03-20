extends AnimatedSprite2D

@export var _animationName = "default"
var end = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	(get_node("OnScreenNotifier") as VisibleOnScreenNotifier2D).screen_entered.connect(AdvanceStage)
	frame = 0
	animation = _animationName

func AdvanceStage() -> void:
	#Theres literally no way this is the best way to loop an animation by hand XD
	frame += 1;
	if (frame == sprite_frames.get_frame_count(_animationName) - 1 and end == true):
		end = false
		frame = 0
	elif (frame == sprite_frames.get_frame_count(_animationName ) - 1 and end == false):
		end = true
		
