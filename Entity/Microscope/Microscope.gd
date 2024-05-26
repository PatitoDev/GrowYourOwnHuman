extends Node2D

signal OnClick;

var isFocused = false;

@onready var sprite = $MicroscopeDish
var hasSample = false;

func _ready():
	setHasSample(false);

func _physics_process(delta):
	if Input.is_action_just_pressed("Interact") && isFocused:
		OnClick.emit();

func _on_area_2d_mouse_entered():
	isFocused = true;

func _on_area_2d_mouse_exited():
	isFocused = false;

func setHasSample(value: bool):
	hasSample = value;
	if (value):
		sprite.frame = 0;
	else:
		sprite.frame = 2;
