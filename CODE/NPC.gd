extends Node2D

@export var sprite: SpriteFrames

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	(get_node("AnimatedSprite2D") as AnimatedSprite2D).sprite_frames = sprite
	(get_node("AnimatedSprite2D") as AnimatedSprite2D).play()
