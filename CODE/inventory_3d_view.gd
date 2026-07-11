@tool
class_name Inventory_3dView
extends Node2D

@onready var itemPath: Path3D = $SubViewport/Inventory3dView/Path3D
@onready var itemsObtained: Node3D = $SubViewport/Inventory3dView/ObtainedItems
var itemAs3DScene: PackedScene
var itemSpots: Array[PathFollow3D]

var rotating: Tween

@export_tool_button("SetScene", "Callable") var setScene: Callable = SetScene

func _ready() -> void:
	itemAs3DScene = ResourceLoader.load("res://SCENES/ASSETS/ItemAs3DModel.tscn")

	SetScene()


func Move(delta: float) -> void:
	var moving: Vector2 = Vector2.ZERO	
	
	moving.x = Input.get_axis("move_left", "move_right")
	
	if moving.x == 1 and (rotating == null or !rotating.is_valid()):
		for spot in itemSpots:
			rotating = create_tween()
			rotating.tween_property(spot, "progress_ratio", spot.progress_ratio+.25, .5)
	if moving.x == -1 and (rotating == null or !rotating.is_valid()):
		for spot in itemSpots:
			rotating = create_tween()
			rotating.tween_property(spot, "progress_ratio", spot.progress_ratio-.25, .5)


func SetScene():
	for n in itemPath.get_children():
		n.queue_free()

	for n in itemsObtained.get_children():
		n.queue_free()
		
	for i in range(3):
		var remoteTransform = RemoteTransform3D.new()
		var newPathFollow = PathFollow3D.new()
		var newItemModel = itemAs3DScene.instantiate()
		
		itemsObtained.add_child(newItemModel) 
	
		newPathFollow.add_child(remoteTransform)
		remoteTransform.update_rotation = false
		remoteTransform.remote_path = newItemModel.get_path()
			
		itemPath.add_child(newPathFollow)
		newPathFollow.progress_ratio = (1.0 + i)/4
		itemSpots.insert(0, newPathFollow)
		
		(newItemModel as ItemAs_3dModel).SetViewRandom()
	
	
