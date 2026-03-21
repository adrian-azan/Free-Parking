class_name OtherCar extends CharacterBody2D

@export var Velocity: Vector2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()


func GetHit(body: Node2D):
	collision_mask = 0
	$Area2D.collision_mask = 0
	velocity = Vector2.ZERO

	var crashPath = Path2D.new()
	var follow = PathFollow2D.new()
	var curve = Curve2D.new()
	
	curve.add_point(global_position)
	curve.add_point(global_position + (Vector2.RIGHT+Vector2.DOWN) * 300)
	curve.add_point(global_position + Vector2.DOWN * 1200)
	
	crashPath.curve = curve
	crashPath.add_child(follow)
	get_tree().root.add_child(crashPath)
	call_deferred("reparent", follow)
	
	create_tween().tween_property(follow, "progress_ratio", 1, .8)
	create_tween().tween_property(self, "rotation_degrees", 900, 1.2)

	create_tween().tween_property(self, "scale", Vector2(4,4), .4)
	create_tween().tween_property(self, "scale", Vector2.ONE, .4).set_delay(.4)
