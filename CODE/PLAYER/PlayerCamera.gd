class_name PlayerCamera extends Camera2D

var aspectRatio: AspectRatioContainer
var maxZoom = Vector2(2.5, 2.5)
var minZoom = Vector2(.1, .1)
var zoomRate = Vector2.ONE / 10

@onready var InventoryUI = $"../Inventory"
@onready var InventoryTransform = $InventoryTransform
var tweening: Tween 

func _ready() -> void:
	InventoryTransform.remote_path = InventoryUI.get_path()
	
	
func ShowInventory():
	if (tweening == null or !tweening.is_valid() and InventoryUI.visible == false):
		(InventoryUI.get_node("Sprite2D2") as AnimatedSprite2D).frame = 1
		(InventoryUI.get_node("Sprite2D") as Sprite2D).visible = true
	
		InventoryUI.visible = true
		InventoryTransform.position = Vector2(0,125)
		tweening = create_tween()
		tweening.tween_property(InventoryTransform, "position", Vector2(0,-30),.5)
		
		
	elif (tweening == null or !tweening.is_valid() and visible == true):
		(InventoryUI.get_node("Sprite2D2") as AnimatedSprite2D).frame = 0
		(InventoryUI.get_node("Sprite2D") as Sprite2D).visible = false

		tweening = create_tween()
		tweening.tween_property(InventoryTransform, "position", Vector2(0,125),.5)
		create_tween().tween_property(InventoryUI, "visible", false,.1).set_delay(.5)	

#TODO: This is a debug feature so we should remove at some point
func _process(delta: float) -> void:	
	if (Input.is_action_just_pressed("ZoomIn")):
		zoom += zoomRate
		zoom = clamp(zoom, minZoom,  maxZoom)
	elif (Input.is_action_just_pressed("ZoomOut")):
		zoom -= zoomRate
		zoom = clamp(zoom, minZoom,  maxZoom)

		
