@tool
extends Path2D

@export var possibleSpriteFrames: Array[SpriteFrames]:
	set(newValue):
		possibleSpriteFrames = newValue
		SetPedestrians()
		
@export var amount: int:
	set(newValue):
		amount = newValue
		SetPedestrians()

@export var zIndex: int:
	set(newValue):
		SetPedestrians()

var pedestrians: Array
var rng: RandomNumberGenerator

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	for p in pedestrians:
		(p as PathFollow2D).progress_ratio += delta * p.get_meta("speed") * p.get_meta("direction")


func SetPedestrians() -> void:

	pedestrians.clear()
	for p in get_children():
		p.queue_free()

	rng = RandomNumberGenerator.new()
	
	for i in range(0, amount):
		var pedestrian: PathFollow2D = (ResourceLoader.load("res://SCENES/Pedestrian.tscn") as PackedScene).instantiate()
		(pedestrian.get_node("Sprite2D") as AnimatedSprite2D).sprite_frames = possibleSpriteFrames.pick_random()
		(pedestrian.get_node("Sprite2D") as AnimatedSprite2D).position = Vector2(0,rng.randf_range(-5,5))
		(pedestrian.get_node("Sprite2D") as AnimatedSprite2D).z_index = zIndex
		create_tween().tween_callback(Callable.create((pedestrian.get_node("Sprite2D") as AnimatedSprite2D), "play")).set_delay(rng.randf_range(.1,2))
		
		pedestrian.set_meta("speed", rng.randf_range(.001,.005))
		pedestrian.set_meta("direction", [-1,1].pick_random())
		
		add_child(pedestrian)		
		pedestrians.push_back(pedestrian)
		
		pedestrian.call_deferred("set_progress_ratio", rng.randf_range(0.0,1.0)) 
