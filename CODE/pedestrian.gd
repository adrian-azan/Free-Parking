extends PathFollow2D

var lastPosition: Vector2;

func _ready() -> void:
	lastPosition = position
	CheckPosition()

func CheckPosition() -> void:
	if position.x < lastPosition.x:
		scale.x = -1	    
	else:
		scale.x = 1
		
	lastPosition = position
	
	create_tween().tween_callback(Callable.create(self, "CheckPosition")).set_delay(.1)