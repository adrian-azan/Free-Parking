extends Node2D

@onready var _gridContainer: GridContainer 
# Try instantiating the layout scene when this global node gets made 		


func _ready() -> void:
	_gridContainer = (ResourceLoader.load("res://SCENES/LabelOverlay.tscn") as PackedScene).instantiate()
	add_child(_gridContainer)



func GetPath() -> NodePath:
	return get_path() 

func SetLabel(idx: int, text: String):
	if ( _gridContainer == null or idx < 0 or idx > _gridContainer.get_child_count()):
		return
		
	(_gridContainer.get_child(idx) as Label).text = text
