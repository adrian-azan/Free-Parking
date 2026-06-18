extends Node2D

var player: PathFollow2D
var cameraLens: Sprite2D

func _ready() -> void:
	$AnimationPlayer.play("PlayerSpotShowDown")
	#$AnimationPlayer.seek(43)	
	
	player = $Path2D/PathFollow2D
	cameraLens = $Path2D/PathFollow2D/Camera2D/Sprite2D
	

func Phase2() -> void:
	player.reparent($Scene2/Path2D)	
	player.progress_ratio = .4
	
	cameraLens.reparent($Scene2/Camera2D)
	
	($Scene2/Camera2D as Camera2D).make_current()
	
