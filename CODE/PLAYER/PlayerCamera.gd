class_name PlayerCamera extends Camera2D


func _ready() -> void:
	$RemoteTransform2D.remote_path = LabelOverlay.get_path()

func _process(delta: float) -> void:	
	if (Input.is_action_just_pressed("ZoomIn")):
		zoom += Vector2.ONE / 10
		zoom = clamp(zoom, Vector2(.1,.1),  Vector2(1.5,1.5))
	elif (Input.is_action_just_pressed("ZoomOut")):
		zoom -= Vector2.ONE / 10
		zoom = clamp(zoom, Vector2(.1,.1),  Vector2(1.5,1.5))

		
