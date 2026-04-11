@tool
extends Path2D



@export var sprite: CompressedTexture2D:
	set(newValue):
		sprite = newValue
		SetPedestrians()
		
@export var amount: int:
	set(newValue):
		amount = newValue
		SetPedestrians()

var pedestrians: Array
var rng: RandomNumberGenerator


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	for p in pedestrians:
		(p as PathFollow2D).progress_ratio += delta * p.get_meta("speed") * p.get_meta("direction")


func SetPedestrians() -> void:

	for p in get_children():
		p.queue_free()

	rng = RandomNumberGenerator.new()
	
	for i in range(0, amount):
		var pedestrian = (ResourceLoader.load("res://SCENES/Pedestrian.tscn") as PackedScene).instantiate() as PathFollow2D
		(pedestrian.get_node("Sprite2D") as Sprite2D).texture = sprite
		(pedestrian.get_node("Sprite2D") as Sprite2D).position = Vector2(0,rng.randf_range(-20,20))
		pedestrian.set_meta("speed", rng.randf_range(.01,.1))
		pedestrian.set_meta("direction", [-1,1].pick_random())
		
		add_child(pedestrian)		
		pedestrians.push_back(pedestrian)
		
		pedestrian.call_deferred("set_progress_ratio", rng.randf_range(0.0,1.0)) 
