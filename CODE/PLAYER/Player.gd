class_name Player extends CharacterBody2D

var _speed = 120

func Move(delta: float) -> void:
	velocity.y = Input.get_axis("move_up", "move_down") * _speed
	velocity.x = Input.get_axis("move_left", "move_right") * _speed
			
	#TODO: A sprint with energy would be good				
	
	move_and_slide()
