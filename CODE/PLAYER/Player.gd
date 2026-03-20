class_name Player extends CharacterBody2D


const SPEED = 300.0


func Move(delta: float) -> void:
	
	var moving: Vector2 = Vector2.ZERO	
	moving.y = Input.get_axis("move_up", "move_down") * 80
	moving.x = Input.get_axis("move_left", "move_right") * 80
			
	#TODO: A sprint with energy would be good			
	
	velocity = moving
	
	move_and_slide()
