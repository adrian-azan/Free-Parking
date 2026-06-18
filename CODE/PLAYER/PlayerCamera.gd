class_name PlayerCamera extends Camera2D

var aspectRatio: AspectRatioContainer
var maxZoom = Vector2(2.5, 2.5)
var minZoom = Vector2(.1, .1)
var zoomRate = Vector2.ONE / 10


func _process(delta: float) -> void:	
	if (Input.is_action_just_pressed("ZoomIn")):
		zoom += zoomRate
		zoom = clamp(zoom, minZoom,  maxZoom)
	elif (Input.is_action_just_pressed("ZoomOut")):
		zoom -= zoomRate
		zoom = clamp(zoom, minZoom,  maxZoom)

		
