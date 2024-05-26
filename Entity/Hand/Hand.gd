extends Node2D

@onready var sprite = $FrogHand

var isGrabbed = false;

func setIsGrabbed(value: bool):
	isGrabbed = value;
	if (value):
		sprite.frame = 1;
	else:
		sprite.frame = 0;

func _physics_process(delta):
	global_position = get_global_mouse_position();
	
	if isGrabbed:
		return;
	
	if Input.is_action_just_pressed("Interact"):
		sprite.frame = 1;
	
	if Input.is_action_just_released("Interact"):
		sprite.frame = 0;
