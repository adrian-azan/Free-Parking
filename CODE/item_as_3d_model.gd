@tool
class_name ItemAs_3dModel extends Node3D

@export var ON: bool
@export_tool_button("Randomize", "Callable") var setScene: Callable = SetViewRandom

var allModels: Array[PackedScene]
@export var selectedModel: int:
	set(new_value):
		if new_value < 0:
			new_value = allModels.size() - 1
		elif new_value >= allModels.size():
			new_value = 0

		if allModels.size() == 0:
			return

		selectedModel = new_value
		SetView()
		
var item: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ON = true
	rotation_degrees = Vector3(-70,0,0)
	selectedModel = 0
	
	for  modelFolder in ResourceLoader.list_directory("res://ART/3D MODELS"):
		print(modelFolder)
		for model in ResourceLoader.list_directory("res://ART/3D MODELS/%s" % modelFolder):
			if model.contains(".gltf"):
				allModels.push_back(ResourceLoader.load("res://ART/3D MODELS/%s/%s" % [modelFolder, model]))
			
	SetView()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if item == null:
		return

	if Engine.is_editor_hint() and ON:	
		item.rotate(Vector3.FORWARD, 1*delta)
	else:
		item.rotate(Vector3.FORWARD, 1*delta)


	
func SetView():
	if item != null:
		item.queue_free()
		
	var gltf: PackedScene = allModels[selectedModel]
	item = gltf.instantiate() as Node3D	
	add_child(item)
	
func SetViewRandom():
	var rand: RandomNumberGenerator = RandomNumberGenerator.new()
	selectedModel = rand.randi_range(0,allModels.size())
	SetView()