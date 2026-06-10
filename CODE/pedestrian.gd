extends PathFollow2D

var lastPosition: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastPosition = position
	CheckPosition()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#do the calc and shit for getting them to face the right way
	pass


func CheckPosition() -> void:
	if position.x < lastPosition.x:
		scale.x = -1	    
	else:
		scale.x = 1
		
	lastPosition = position
	
	create_tween().tween_callback(Callable.create(self, "CheckPosition")).set_delay(.1)
