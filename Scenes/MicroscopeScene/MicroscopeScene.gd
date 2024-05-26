extends Node2D

var SPEED = 5;
@onready var camera = $Camera

func _physics_process(delta):
	var direction = Vector2(Input.get_axis('Left', 'Right'), Input.get_axis('Up', 'Down'));
	var velocity = direction * SPEED;
	if (direction == Vector2(0,0)):
		velocity = velocity.move_toward(Vector2(0,0), delta);
	
	camera.global_position += velocity;
