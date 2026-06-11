extends Node2D

@export var spriteFrames: SpriteFrames

func _ready() -> void:	
	(get_node("AnimatedSprite2D") as AnimatedSprite2D).sprite_frames = spriteFrames
	(get_node("AnimatedSprite2D") as AnimatedSprite2D).play()
